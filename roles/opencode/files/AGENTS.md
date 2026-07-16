<!-- CODEGRAPH_START -->
## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at the repo root), reach for it BEFORE grep/find or reading files when you need to understand or locate code:

- **MCP tool** (when available): `codegraph_explore` answers most code questions in one call — the relevant symbols' verbatim source plus the call paths between them, including dynamic-dispatch hops grep can't follow. Name a file or symbol in the query to read its current line-numbered source. If it's listed but deferred, load it by name via tool search.
- **Shell** (always works): `codegraph explore "<symbol names or question>"` prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is the user's decision.
<!-- CODEGRAPH_END -->

<!-- RTK_START -->
## RTK

RTK (Rust Token Killer) reduces the shell output sent to the model. The OpenCode plugin automatically rewrites supported Bash and shell commands, so use normal command syntax and let the plugin apply RTK filtering.

- Keep CodeGraph and purpose-built file, search, and read tools as the first choice; do not replace them with shell commands merely to use RTK.
- When invoking RTK explicitly, prefix the command with `rtk`, for example: `rtk git status`, `rtk npm test`, `rtk pytest`, or `rtk cargo test`.
- Use `rtk proxy <command>` only when exact, unfiltered output is required for debugging.
- If a failed command reports a saved full-output path, inspect that output before rerunning the command unfiltered.
- Use `rtk gain`, `rtk gain --history`, and `rtk discover` to inspect savings and identify missed optimization opportunities.
- If RTK is unavailable or its rewrite fails, run the original command normally; do not install or reconfigure RTK unless the user requests it.
<!-- RTK_END -->
