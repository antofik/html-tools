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

- **Base64 Tool** (`base64_tool.html`)
  - Uses a two-panel layout with plain UTF-8 text on the left and encoded output on the right.
  - Both panels are editable and conversion happens automatically while the user types or pastes input.
  - Supports left-to-right encoding and right-to-left decoding.
  - Supports standard Base64 and Base64URL alphabets.
  - Supports optional padding emission for encoded output.
  - Accepts padded and unpadded Base64/Base64URL input during decoding.
  - Uses UTF-8-safe browser encoding and decoding for text workflows.
  - Reports decode errors instead of guessing when input is not valid Base64 text.
  - Persists both panel contents and selected options in `localStorage`.

- **JWT Inspector** (`jwt_inspector.html`)
  - Parses an existing JWT token into header, payload, and signature parts.
  - Decodes Base64URL header and payload and shows them in editable JSON panels.
  - Allows editing header, payload, and signature parts locally.
  - Rebuilds the JWT token automatically when editable parts change.
  - Supports signature generation modes for local workflows: keep edited signature, fake signature, or empty signature.
  - Surfaces basic diagnostics such as malformed token structure, Base64URL decode errors, JSON parse errors, and simple `exp` status checks.
  - Is intended for offline inspection and local token-shape generation, not for real cryptographic verification.
  - Persists token input, editable parts, and selected signature mode in `localStorage`.

### Notes For Future Updates

- Keep tools as single-file HTML documents unless there is a clear reason to change the repository model.
- Update this document when a new tool is added, a tool is removed, or user-visible behavior changes.
- Do not claim persistence, export, copy, or advanced interactions unless they are present in the actual HTML implementation.

### Candidate Tools

The following tools are planned candidates and are **not implemented yet**. These descriptions are drafts and should be adjusted before development.
