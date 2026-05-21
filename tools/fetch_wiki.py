"""
Fetch FFXIV Classic wiki pages from web.archive.org and save as raw HTML.
Run via PowerShell since /tmp and curl direct don't work cross-platform here.
"""
import os
import sys
import time
from pathlib import Path
from urllib.request import urlopen, Request
from urllib.error import URLError

WAYBACK = "https://web.archive.org/web/20250115065459/http://ffxivclassic.fragmenterworks.com/wiki/index.php/"

PAGES = [
    "Game_Opcodes",
    "Packet_Headers",
    "ZiPatch_File_Structure",
    "Debug_Commands",
    "Setting_up_the_project",
    "Math_Formula",
    "Regions",
    "Points_of_interest",
    "NPC_Actors",
    "Monster_Models",
    "BgObj_Models",
    "Animations_and_VFX",
    "Populace_Animation",
    "Music",
    "Weather",
    "Quests",
    "Dungeons",
    "Retail_Patcher_and_Login",
    "Utilities",
    "Unofficial_Additions",
    "Unfinished_Content",
    "Unknowns",
    "FAQs",
]


def fetch(page: str, dst_dir: Path) -> bool:
    url = WAYBACK + page
    out = dst_dir / f"{page}.html"
    if out.exists() and out.stat().st_size > 5000:
        print(f"SKIP {page} (already cached)")
        return True
    req = Request(url, headers={"User-Agent": "MeteorReborn-DocsBuilder/1.0"})
    try:
        with urlopen(req, timeout=30) as r:
            data = r.read()
        out.write_bytes(data)
        print(f"OK   {page} ({len(data)} bytes)")
        return True
    except URLError as e:
        print(f"FAIL {page}: {e}")
        return False
    except Exception as e:
        print(f"FAIL {page}: {e}")
        return False


def main():
    dst = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("wiki_cache")
    dst.mkdir(parents=True, exist_ok=True)
    ok = 0
    fail = 0
    for p in PAGES:
        if fetch(p, dst):
            ok += 1
        else:
            fail += 1
        time.sleep(8)  # archive.org rate limits — spread the calls out
    print(f"\nDONE: ok={ok} fail={fail} out={dst.absolute()}")


if __name__ == "__main__":
    main()
