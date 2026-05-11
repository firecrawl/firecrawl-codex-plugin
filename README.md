# Firecrawl Codex plugin

OpenAI [Codex plugin](https://developers.openai.com/codex/plugins/build) that bundles Firecrawl **CLI workflow skills** (search, scrape, crawl, map, interact, agent, parse, download) and the **Firecrawl MCP server** for tool-style access.

Canonical skill sources live in [`firecrawl/cli`](https://github.com/firecrawl/cli) (`cli/skills/`). This repo vendors copies for the Codex plugin distribution; refresh when CLI skills change materially.

## Requirements

- [Node.js](https://nodejs.org/) 18+ (for `npx firecrawl-mcp` when using bundled MCP).
- [Firecrawl CLI](https://www.npmjs.com/package/firecrawl-cli) installed and authenticated for skill workflows that shell out to `firecrawl`:

  ```bash
  npm install -g firecrawl-cli
  firecrawl login --browser
  ```

  Or set `FIRECRAWL_API_KEY` in your environment.

## Install in Codex (local marketplace)

Until the plugin is listed in the official Codex Plugin Directory, wire a **repo** or **personal** marketplace as described in the OpenAI docs.

### Option A: Git clone next to your project

1. Clone this repository (for example into `plugins/firecrawl-codex-plugin` at the root of the repo where you use Codex).

2. Add `.agents/plugins/marketplace.json` at that repo root (see [`examples/marketplace.json`](examples/marketplace.json)). Point `source.path` at the plugin folder with a `./`-prefixed path relative to the marketplace file’s directory.

3. Set MCP credentials in `~/.codex/config.toml` so the bundled server can authenticate (do **not** commit secrets):

   ```toml
   [mcp_servers.firecrawl.env]
   FIRECRAWL_API_KEY = "fc-YOUR-API-KEY"
   ```

   Alternatively use a [remote MCP URL](https://docs.firecrawl.dev/quickstarts/codex-cli) and disable or omit the bundled MCP entry in your Codex config if you prefer.

4. Restart Codex. Open **Plugins** (Codex app) or run `/plugins` in Codex CLI, pick your marketplace, install **Firecrawl**, enable the plugin.

### Option B: Codex CLI marketplace add

From the OpenAI docs:

```bash
codex plugin marketplace add ./path-to-marketplace-root
```

Use a marketplace JSON that references this plugin directory (same shape as `examples/marketplace.json`).

## Bundled MCP

[`.mcp.json`](.mcp.json) runs `npx -y firecrawl-mcp`. You must provide `FIRECRAWL_API_KEY` via Codex MCP server environment configuration.

## Smoke checks (after install)

In a new Codex thread, try:

1. “Search the web for the latest Firecrawl changelog and summarize.”
2. “Scrape https://docs.firecrawl.dev and list top-level sections.”
3. “Use Firecrawl MCP to call `firecrawl_scrape` on https://example.com.” (if MCP is enabled)

CLI-only checks from a terminal:

```bash
firecrawl --status
firecrawl search "firecrawl web scraping" --limit 3 --json
```

The `_local/` directory is gitignored; use it in your clone for any markdown or notes you do not want committed.

## License

MIT — see [LICENSE](LICENSE).
