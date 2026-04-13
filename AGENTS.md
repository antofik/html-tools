### Description

This repository contains arbitrary tools that:
- represented as single self-contained HTML file
- do not require any external resources (e.g. JS/CSS scripts)

### Common Constraints

- Tools are local-first and work without external dependencies.
- UI is a light/white theme.
- Controls use SVG icon buttons.
- Files are loaded from local disk with browser file inputs and `FileReader`.
- The repository is intentionally minimal: open the HTML files directly in a browser.

### Tools

- **Diff Viewer** (`diff_viewer.html`)
  - Compares two text inputs line-by-line.
  - Supports loading each side from local files or editing/pasting text directly in the textareas.
  - Supports drag and drop for both input files.
  - Shows both `side-by-side` and `unified` diff views.
  - Highlights intraline character changes for modified lines.
  - Shows summary counters for unchanged, added, removed, and changed lines.
  - Can swap left/right inputs.
  - Can clear the current comparison.
  - Can export the unified diff as a separate self-contained HTML file.

- **JSON Formatter** (`json_formatter.html`)
  - Loads JSON from a local file or accepts pasted/typed JSON.
  - Formats JSON into a normalized pretty-printed representation.
  - Renders a structured tree view with per-node collapse/expand.
  - Supports `Expand all` and `Collapse all`.
  - Supports copying the formatted JSON to the clipboard.
  - Supports downloading formatted output as `*.formatted.json`.
  - Supports toggling line wrap in the raw JSON editor.
  - Supports hiding/showing the raw JSON panel while keeping the tree visible.
  - Persists editor text, file metadata, collapsed tree state, and UI settings in `localStorage`.
  - Restores saved state from `localStorage` on reload when possible.
  - Uses large-JSON safeguards: large trees start collapsed and child rendering is chunked/lazy to avoid blocking the UI.
  - Supports `Ctrl+Enter` / `Cmd+Enter` to trigger formatting.

### Notes For Future Updates

- Keep tools as single-file HTML documents unless there is a clear reason to change the repository model.
- Update this document when a new tool is added, a tool is removed, or user-visible behavior changes.
- Do not claim persistence, export, copy, or advanced interactions unless they are present in the actual HTML implementation.
