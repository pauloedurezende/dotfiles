---
description: Provides RTK guidance for efficient shell output.
mode: primary
---

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
