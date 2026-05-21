// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// GitHub Pages bajo `Yokimitsuro/MeteorReborn` se sirve en /MeteorReborn/.
// Cambiar a custom domain si se compra (e.g. `meteorreborn.dev`).
const SITE = 'https://yokimitsuro.github.io';
const BASE = '/MeteorReborn';

export default defineConfig({
	site: SITE,
	base: BASE,
	integrations: [
		starlight({
			title: 'Meteor Reborn',
			description:
				'FFXIV 1.0 (1.23b) server emulator — port of Project Meteor to .NET 10 + PostgreSQL + Docker.',
			social: [
				{ icon: 'github', label: 'GitHub', href: 'https://github.com/Yokimitsuro/MeteorReborn' },
			],
			editLink: {
				baseUrl: 'https://github.com/Yokimitsuro/MeteorReborn/edit/develop/docs/',
			},
			sidebar: [
				{
					label: 'Getting Started',
					items: [
						{ label: 'Overview', slug: 'getting-started/overview' },
						{ label: 'Quick start (Docker)', slug: 'getting-started/docker' },
						{ label: 'Without Docker', slug: 'getting-started/native' },
						{ label: 'Client setup & launcher', slug: 'getting-started/launcher' },
					],
				},
				{
					label: 'Architecture',
					items: [
						{ label: 'Overview', slug: 'architecture/overview' },
						{ label: 'Codebase tour', slug: 'architecture/codebase-tour' },
						{ label: 'Packet flow', slug: 'architecture/packet-flow' },
						{ label: 'Database schema', slug: 'architecture/database' },
						{ label: 'Lua engine', slug: 'architecture/lua' },
						{ label: 'Port notes', slug: 'architecture/port-notes' },
					],
				},
				{
					label: 'Contributing',
					items: [
						{ label: 'How to help', slug: 'contributing/overview' },
						{ label: 'Dev environment', slug: 'contributing/dev-setup' },
						{ label: 'Code conventions', slug: 'contributing/conventions' },
						{ label: 'Git workflow', slug: 'contributing/git-workflow' },
						{ label: 'Recipes (add X)', slug: 'contributing/recipes' },
						{ label: 'Debugging', slug: 'contributing/debugging' },
						{ label: 'Roadmap', slug: 'contributing/roadmap' },
					],
				},
				{
					label: 'Reference',
					items: [
						{ label: 'GM commands', slug: 'reference/gm-commands' },
						{ label: 'Game opcodes', slug: 'reference/game-opcodes' },
						{ label: 'Packet headers', slug: 'reference/packet-headers' },
						{ label: 'ZIPATCH file structure', slug: 'reference/zipatch' },
						{ label: 'Math formulas', slug: 'reference/math-formulas' },
						{ label: 'Ports & services', slug: 'reference/ports' },
					],
				},
				{
					label: 'World data',
					items: [
						{ label: 'Regions & zones', slug: 'world/regions' },
						{ label: 'Points of interest', slug: 'world/points-of-interest' },
						{ label: 'NPC actors', slug: 'world/npc-actors' },
						{ label: 'Monster models', slug: 'world/monster-models' },
						{ label: 'BG objects', slug: 'world/bg-models' },
						{ label: 'Animations & VFX', slug: 'world/animations' },
						{ label: 'Music', slug: 'world/music' },
						{ label: 'Weather', slug: 'world/weather' },
						{ label: 'Quests', slug: 'world/quests' },
						{ label: 'Dungeons', slug: 'world/dungeons' },
					],
				},
				{
					label: 'Project',
					items: [
						{ label: 'Setting up the build', slug: 'project/build' },
						{ label: 'Utilities', slug: 'project/utilities' },
						{ label: 'Unofficial additions', slug: 'project/unofficial-additions' },
						{ label: 'Unfinished content', slug: 'project/unfinished-content' },
						{ label: 'Open questions', slug: 'project/unknowns' },
						{ label: 'FAQs', slug: 'project/faqs' },
					],
				},
			],
		}),
	],
});
