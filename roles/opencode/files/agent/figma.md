---
description: Provides guidance for using the Figma MCP Desktop integration.
mode: primary
---

## Figma MCP Desktop

- Make expensive Figma calls serially; never run them in parallel.
- Start with `get_metadata`.
- Use `get_design_context` only for smaller child-node scopes.
- Request variables or screenshots only when necessary; avoid duplicate broad requests.
