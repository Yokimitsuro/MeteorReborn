"""
Convert FFXIV Classic wiki HTML pages (cached from web.archive.org) into clean
Markdown suitable for Starlight.

- Strips MediaWiki chrome (nav, sidebars, edit links, archive.org banner).
- Keeps the #mw-content-text block (the actual article body).
- Converts <h1..h6>, <p>, <ul>/<ol>/<li>, <table>, <pre>/<code>, <a>, <strong>/<em>.
- Rewrites internal wiki links to local doc slugs where possible.
- Prepends Starlight frontmatter (title from page name, attribution to upstream wiki).

Usage:
    python html_to_md.py <wiki_cache_dir> <out_dir> [page_to_slug_mapping.json]
"""
import json
import re
import sys
from html.parser import HTMLParser
from pathlib import Path

UPSTREAM_BASE = "http://ffxivclassic.fragmenterworks.com/wiki/index.php"

# Map of upstream wiki page name → docs slug (relative to /docs/)
PAGE_TO_SLUG = {
    "Game_Opcodes": "reference/game-opcodes",
    "Packet_Headers": "reference/packet-headers",
    "ZiPatch_File_Structure": "reference/zipatch",
    "Debug_Commands": "reference/gm-commands",
    "Setting_up_the_project": "project/build",
    "Math_Formula": "reference/math-formulas",
    "Regions": "world/regions",
    "Points_of_interest": "world/points-of-interest",
    "NPC_Actors": "world/npc-actors",
    "Monster_Models": "world/monster-models",
    "BgObj_Models": "world/bg-models",
    "Animations_and_VFX": "world/animations",
    "Populace_Animation": "world/populace-animation",
    "Music": "world/music",
    "Weather": "world/weather",
    "Quests": "world/quests",
    "Dungeons": "world/dungeons",
    "Retail_Patcher_and_Login": "reference/retail-patcher",
    "Utilities": "project/utilities",
    "Unofficial_Additions": "project/unofficial-additions",
    "Unfinished_Content": "project/unfinished-content",
    "Unknowns": "project/unknowns",
    "FAQs": "project/faqs",
}

PAGE_TITLES = {
    "Game_Opcodes": "Game opcodes",
    "Packet_Headers": "Packet headers",
    "ZiPatch_File_Structure": "ZIPATCH file structure",
    "Debug_Commands": "GM / Debug commands",
    "Setting_up_the_project": "Setting up the build",
    "Math_Formula": "Math formulas",
    "Regions": "Regions & zones",
    "Points_of_interest": "Points of interest",
    "NPC_Actors": "NPC actors",
    "Monster_Models": "Monster models",
    "BgObj_Models": "BG objects",
    "Animations_and_VFX": "Animations & VFX",
    "Populace_Animation": "Populace animation",
    "Music": "Music",
    "Weather": "Weather",
    "Quests": "Quests",
    "Dungeons": "Dungeons",
    "Retail_Patcher_and_Login": "Retail patcher & login flow",
    "Utilities": "Utilities",
    "Unofficial_Additions": "Unofficial additions",
    "Unfinished_Content": "Unfinished content",
    "Unknowns": "Open questions / unknowns",
    "FAQs": "FAQs",
}


class WikiHtmlParser(HTMLParser):
    """
    Minimal HTML→Markdown converter tuned for MediaWiki output.

    State machine:
    - In_content: True once we see <div id="mw-content-text">.
    - skip_depth: nested tag count for blocks we want to ignore entirely
      (edit links, toc, navboxes, etc).
    - Capturing emits chunks to `out`.
    """

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.in_content = False
        self.skip_depth = 0
        self.out = []
        self.tag_stack = []
        self.list_stack = []  # ('ul', 0) or ('ol', n)
        self.in_pre = False
        self.in_code_inline = False
        self.in_table = False
        self.table_row_buffer = []
        self.table_cell_buffer = []
        self.table_rows = []
        self.row_is_header = False
        self.current_href = None
        self.heading_level = 0
        self.heading_buffer = []

    # ── lifecycle helpers ────────────────────────────────────────────────────

    def _emit(self, s):
        if self.in_content and self.skip_depth == 0:
            if self.heading_level:
                self.heading_buffer.append(s)
            else:
                self.out.append(s)

    def _newline(self):
        if self.out and not self.out[-1].endswith("\n"):
            self.out.append("\n")

    def _para(self):
        self._newline()
        if not (self.out and self.out[-1].endswith("\n\n")):
            self.out.append("\n")

    # ── tag handlers ─────────────────────────────────────────────────────────

    def handle_starttag(self, tag, attrs):
        attrs_d = dict(attrs)

        # Detect main content container — only emit text inside it.
        if tag == "div" and attrs_d.get("id") == "mw-content-text":
            self.in_content = True
            self.tag_stack.append(("content_marker", True))
            return

        if not self.in_content:
            return

        # Skip MediaWiki chrome and archive.org banners.
        skip_classes = {
            "mw-editsection",
            "toc",
            "noprint",
            "navbox",
            "metadata",
            "wm-ipp",          # archive.org banner
            "printfooter",
            "catlinks",
            "thumb",
            "thumbinner",
            "magnify",
        }
        skip_ids = {"siteSub", "contentSub", "catlinks", "jump-to-nav", "wm-ipp-base"}
        cls = attrs_d.get("class", "")
        if attrs_d.get("id") in skip_ids or any(c in skip_classes for c in cls.split()):
            self.skip_depth += 1
            self.tag_stack.append((tag, "skip"))
            return

        if self.skip_depth > 0:
            self.tag_stack.append((tag, "in_skip"))
            return

        # Block tags
        if tag == "p":
            self._para()
        elif tag in ("h1", "h2", "h3", "h4", "h5", "h6"):
            self.heading_level = int(tag[1])
            self.heading_buffer = []
            self._para()
        elif tag == "ul":
            self.list_stack.append(("ul", 0))
        elif tag == "ol":
            self.list_stack.append(("ol", 1))
        elif tag == "li":
            self._newline()
            if self.list_stack:
                kind, idx = self.list_stack[-1]
                indent = "  " * (len(self.list_stack) - 1)
                if kind == "ul":
                    self._emit(f"{indent}- ")
                else:
                    self._emit(f"{indent}{idx}. ")
                    self.list_stack[-1] = (kind, idx + 1)
        elif tag == "pre":
            self.in_pre = True
            self._para()
            self._emit("```\n")
        elif tag == "code":
            if not self.in_pre:
                self.in_code_inline = True
                self._emit("`")
        elif tag == "strong" or tag == "b":
            self._emit("**")
        elif tag in ("em", "i"):
            self._emit("*")
        elif tag == "a":
            self.current_href = attrs_d.get("href", "")
            self._emit("[")
        elif tag == "br":
            self._emit("\n")
        elif tag == "table":
            self.in_table = True
            self.table_rows = []
            self.row_is_header = False
            self._para()
        elif tag == "tr":
            self.table_cell_buffer = []
        elif tag in ("th", "td"):
            self.table_cell_buffer.append([])
            if tag == "th":
                self.row_is_header = True
        elif tag == "hr":
            self._para()
            self._emit("---")
            self._para()

        self.tag_stack.append((tag, None))

    def handle_endtag(self, tag):
        if not self.tag_stack:
            return

        # Pop matching, even when nested unknowns appear
        popped = None
        for i in range(len(self.tag_stack) - 1, -1, -1):
            if self.tag_stack[i][0] == tag:
                popped = self.tag_stack.pop(i)
                break
        if popped is None:
            return

        state = popped[1]
        if state == "skip":
            self.skip_depth = max(0, self.skip_depth - 1)
            return
        if state == "in_skip":
            return
        if state is True and tag == "div":
            # closing the main content marker
            self.in_content = False
            return

        if not self.in_content:
            return

        # Close block tags
        if tag == "p":
            self._para()
        elif tag in ("h1", "h2", "h3", "h4", "h5", "h6"):
            level = self.heading_level
            text = "".join(self.heading_buffer).strip()
            self.heading_level = 0
            self.heading_buffer = []
            if text:
                # Bump down 1 level so the page's H1 is reserved for Starlight frontmatter title.
                effective = min(6, level + 1)
                self.out.append(f"\n{'#' * effective} {text}\n\n")
        elif tag in ("ul", "ol"):
            if self.list_stack:
                self.list_stack.pop()
            self._newline()
        elif tag == "li":
            pass
        elif tag == "pre":
            self.in_pre = False
            self._newline()
            self._emit("```")
            self._para()
        elif tag == "code":
            if self.in_code_inline:
                self.in_code_inline = False
                self._emit("`")
        elif tag in ("strong", "b"):
            self._emit("**")
        elif tag in ("em", "i"):
            self._emit("*")
        elif tag == "a":
            href = self.current_href or ""
            self.current_href = None
            href_clean = href.split("/web/")[-1] if "/web/" in href else href
            # Internal wiki links: rewrite to local slug if mapped, else upstream
            m = re.search(r"index\.php/([^?#]+)", href_clean)
            if m:
                page = m.group(1).rstrip("/")
                slug = PAGE_TO_SLUG.get(page)
                if slug:
                    href_clean = f"/MeteorReborn/{slug}/"
                else:
                    href_clean = f"{UPSTREAM_BASE}/{page}"
            else:
                # External link — keep as is
                if href_clean.startswith("http://web.archive.org"):
                    # Pure archive URL we can't decode — drop the prefix
                    href_clean = re.sub(r"^https?://web\.archive\.org/web/\d+/", "", href_clean)
            self._emit(f"]({href_clean})")
        elif tag == "table":
            self.in_table = False
            self._render_table()
            self._para()
        elif tag == "tr":
            if self.table_cell_buffer:
                self.table_rows.append((self.row_is_header, list(self.table_cell_buffer)))
                self.row_is_header = False
        elif tag in ("th", "td"):
            pass

    def handle_data(self, data):
        if not self.in_content or self.skip_depth:
            return
        if self.in_table and self.table_cell_buffer:
            # Capture into the current cell
            self.table_cell_buffer[-1].append(data)
            return
        if self.heading_level:
            self.heading_buffer.append(data)
            return
        if self.in_pre:
            self._emit(data)
            return
        # Collapse newlines/whitespace in normal text
        text = re.sub(r"\s+", " ", data)
        self._emit(text)

    def _render_table(self):
        if not self.table_rows:
            return
        # Build markdown table
        rows = []
        for is_header, cells in self.table_rows:
            cell_texts = ["".join(c).strip().replace("\n", " ").replace("|", "\\|") for c in cells]
            rows.append((is_header, cell_texts))
        if not rows:
            return
        # Find max columns
        ncols = max(len(r[1]) for r in rows)
        # Pad cells
        for is_header, cells in rows:
            while len(cells) < ncols:
                cells.append("")

        # If first row isn't header, fabricate one
        has_header = rows[0][0]
        if not has_header:
            header = [""] * ncols
            rows.insert(0, (True, header))

        # Emit
        self.out.append("\n")
        self.out.append("| " + " | ".join(rows[0][1]) + " |\n")
        self.out.append("|" + "|".join(["---"] * ncols) + "|\n")
        for is_header, cells in rows[1:]:
            self.out.append("| " + " | ".join(cells) + " |\n")

    def get_markdown(self):
        md = "".join(self.out)
        # Collapse 3+ newlines to 2
        md = re.sub(r"\n{3,}", "\n\n", md)
        # Trim leading/trailing whitespace
        return md.strip() + "\n"


def convert_one(html_path: Path, out_dir: Path, slug_root: Path):
    page = html_path.stem
    slug = PAGE_TO_SLUG.get(page)
    if not slug:
        print(f"SKIP {page}: no slug mapping")
        return
    title = PAGE_TITLES.get(page, page.replace("_", " "))

    raw = html_path.read_bytes().decode("utf-8", errors="replace")
    parser = WikiHtmlParser()
    parser.feed(raw)
    body = parser.get_markdown()

    out_file = slug_root / f"{slug}.md"
    out_file.parent.mkdir(parents=True, exist_ok=True)
    out_file.write_text(
        f"---\n"
        f"title: {title}\n"
        f"description: Mirrored from the FFXIV Classic Wiki for offline reference.\n"
        f"---\n\n"
        f":::note[Source]\n"
        f"This page is mirrored from the [FFXIV Classic Wiki]"
        f"({UPSTREAM_BASE}/{page}). Original authors retain credit; "
        f"reproduced here because the upstream wiki is intermittently offline.\n"
        f":::\n\n"
        f"{body}",
        encoding="utf-8",
    )
    print(f"OK   {page} -> {out_file.relative_to(slug_root.parent.parent)}")


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        sys.exit(1)
    cache = Path(sys.argv[1])
    out_dir = Path(sys.argv[2])
    for html in sorted(cache.glob("*.html")):
        convert_one(html, out_dir, out_dir)


if __name__ == "__main__":
    main()
