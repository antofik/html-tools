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

- **Timestamp Converter** (`timestamp_converter.html`)
  - Uses a two-panel layout with both panels editable.
  - Scans automatically while the user types or pastes input, without requiring a convert button.
  - Converts likely Unix timestamps from the left panel into backtick-wrapped ISO-8601 UTC values in the right panel.
  - Converts backtick-wrapped ISO-8601 UTC values from the right panel back into Unix timestamps in the left panel.
  - Attempts whole-input JSON parsing first; valid JSON is transformed structurally and rendered back as formatted JSON.
  - Falls back to plain-text scanning when the input is not valid JSON.
  - Detects likely Unix timestamps in text, JSON numbers, and numeric strings.
  - Supports both second-based and millisecond-based Unix timestamps for left-to-right conversion.
  - Includes a summary section with counts and a table of detected values, inferred units, converted values, and locations.
  - Persists both panel contents in `localStorage`.

### Notes For Future Updates

- Keep tools as single-file HTML documents unless there is a clear reason to change the repository model.
- Update this document when a new tool is added, a tool is removed, or user-visible behavior changes.
- Do not claim persistence, export, copy, or advanced interactions unless they are present in the actual HTML implementation.

### Candidate Tools

The following tools are planned candidates and are **not implemented yet**. These descriptions are drafts and should be adjusted before development.

- **JWT Inspector** (`jwt_inspector.html`, planned)
  - Parses an existing JWT into header, payload, and signature parts.
  - Decodes Base64URL header and payload and shows them as editable JSON.
  - Allows editing all three JWT parts locally.
  - Rebuilds a JWT token from header, payload, and signature input.
  - Supports generating a fake signature for local testing scenarios where cryptographic validity is not required.
  - Intended for offline inspection and local token-shape generation, not only for parsing.
  - May later support additional diagnostics such as malformed token detection, expiry display, and algorithm hints.

- **Base64 Encoder/Decoder** (`base64_tool.html`, planned)
  - Provides local offline Base64 encode/decode functionality.
  - Intended for text-first workflows in a browser.
  - May use a two-panel live conversion layout similar to other tools in this repository.
  - Should support standard Base64 and Base64URL variants.
  - Should handle UTF-8 text correctly.
  - May include automatic mode detection, normalization, copy actions, and padding controls.
