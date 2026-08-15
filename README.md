# opencode-onboarding

One paste and you're running [OpenCode 2](https://opencode.ai/v2/docs/) (`opencode2`) with the [oh-my-opencode-slim](https://github.com/alvinunreal/oh-my-opencode-slim) multi-agent suite — sensible defaults, no decisions to make.

**Landing page:** enable GitHub Pages (Settings → Pages → Deploy from branch → `main` / root) and this repo serves `index.html`.

## The copy-paste setup prompt

Open your current AI coding agent (Claude Code, Codex CLI, Cursor, Gemini CLI, anything) and paste this. Raw version: [`prompt.txt`](prompt.txt).

```text
Set me up with OpenCode 2 (opencode2) plus the oh-my-opencode-slim multi-agent suite. Use the default setup everywhere: install, configure, verify. Don't ask me to pick models or presets - the defaults are what I want.

Steps:

1. Install OpenCode 2 globally. It runs as `opencode2` and will not touch an existing `opencode` v1 install:

       npm install -g @opencode-ai/cli@next

   (Bun users: `bun install -g --trust @opencode-ai/cli@next`. On Windows, install and run it inside WSL.)
   Verify with `opencode2 --version`.

2. Install the oh-my-opencode-slim plugin:

       npx oh-my-opencode-slim@latest install

   (or `bunx oh-my-opencode-slim@latest install`). Accept every installer default. The default preset (OpenAI) is fine.

3. Make sure OpenCode 2 loads the plugin. The installer usually registers it. If not, follow the "OpenCode v2 (opencode2) Compatibility" section of the plugin README and add the plugin entry to the config file OpenCode 2 loads on this machine (official v2 docs put global config at ~/.config/opencode/opencode.json with a `plugins` array; the plugin README references ~/.config/opencode2/). Keep every existing entry.

4. Check that at least one model provider is connected. If none is, tell me to launch `opencode2`, run /connect, and pick a provider, then continue once it is connected.

5. Verify the team. Launch `opencode2` in my project, send the message "ping all agents", and report which of the seven agents answered.

Rules:

- Never overwrite or delete an existing config without showing me the exact change first and getting my OK.
- If a step fails, stop, print the full error, and propose a fix before continuing.
- Finish with a short summary: what was installed, where the config files live, and how to switch model presets later with /preset.

References: https://opencode.ai/v2/docs/ - https://github.com/alvinunreal/oh-my-opencode-slim
```

## Manual install

```sh
npm install -g @opencode-ai/cli@next
```

```sh
bun install -g --trust @opencode-ai/cli@next
```

```sh
curl -fsSL https://raw.githubusercontent.com/anomalyco/opencode/v2/install | bash
```

Install the plugin:

```sh
npx oh-my-opencode-slim@latest install
```

Make sure OpenCode 2 loads it. Global config lives at `~/.config/opencode/opencode.json` (official v2 location, `plugins` array):

```json
{ "plugins": ["oh-my-opencode-slim"] }
```

> Note: the plugin's README shows a `plugin` entry under `~/.config/opencode2/` for v2 — the `npx` installer wires this up either way. If `opencode2` starts without the slim agents, check that entry against the README's "OpenCode v2 Compatibility" section.

Connect a provider and verify:

```sh
opencode2            # then run /connect to pick a provider
```

Send `ping all agents` in the session — every agent should answer.

## What you get

- `opencode2` — the OpenCode 2 CLI, installed side by side with v1 (v1's `opencode` binary is untouched)
- oh-my-opencode-slim — seven specialized agents (Orchestrator, Explorer, Oracle, Council, Librarian, Designer, Fixer) under one orchestrator, on the default preset
- Default models out of the box; swap the whole team at runtime with `/preset` (see the [preset docs](https://github.com/alvinunreal/oh-my-opencode-slim/tree/master/docs) — including a free preset)

## Notes

- Windows: OpenCode 2 beta recommends [WSL](https://learn.microsoft.com/windows/wsl/install).
- OpenCode 2 is beta; APIs and config may change. Docs: <https://opencode.ai/v2/docs/>

## Credits

- [OpenCode](https://opencode.ai) by [anomalyco](https://github.com/anomalyco/opencode)
- [oh-my-opencode-slim](https://github.com/alvinunreal/oh-my-opencode-slim) by Boring Dystopia Development
