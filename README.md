# HTML Tools

Single-file HTML tools for offline work in environments where you cannot install any external applications

## Repository Model

Each tool is a self-contained page:

- no build step
- no package installation
- no external JS or CSS dependencies
- open the `*.html` file directly in a browser

The tools are designed for offline and local workflows

## Included Tools

### `diff_viewer.html`

Compares two text inputs or files and renders the result in browser.

Features:

- plain-text diff
- `Env` mode for `key=value` comparison by key
- `Log` mode for log-oriented comparison
- `JSON` mode with structural comparison
- `YAML` mode with structural comparison
- side-by-side and unified views
- intraline change highlighting
- whitespace-ignore mode
- invisible-character visualization
- ignore patterns and skip-line patterns
- drag-and-drop file loading
- paired file opening from the UI
- refresh from disk for files opened through the File System Access picker
- unified diff export as standalone HTML
- toggle to show or hide unchanged lines

### `json_formatter.html`

Formats JSON and renders a structured tree view.

Features:

- load JSON from file or paste text
- normalized pretty-print formatting
- collapsible tree rendering
- expand all / collapse all
- copy formatted JSON
- download formatted output
- wrap toggle for raw editor
- raw panel hide/show
- persisted editor state and UI settings
- large-JSON safeguards

### `timestamp_converter.html`

Converts likely Unix timestamps and ISO-8601 UTC values in both directions.

Features:

- two editable panels
- automatic conversion while typing or pasting
- whole-input JSON transformation when input is valid JSON
- fallback text scanning when input is not JSON
- seconds and milliseconds timestamp detection
- summary table of detected conversions
- persisted panel contents

### `base64_tool.html`

Encodes and decodes Base64 and Base64URL text locally.

Features:

- two editable panels
- automatic conversion while typing
- Base64 and Base64URL support
- optional padding on encode
- padded and unpadded decoding
- UTF-8-safe text workflows
- explicit decode error reporting
- persisted contents and options

### `jwt_inspector.html`

Inspects and edits JWT structure locally.

Features:

- parse token into header, payload, and signature
- editable decoded JSON for header and payload
- editable signature segment
- automatic token rebuild
- signature generation modes for local workflows
- malformed token and decode diagnostics
- simple `exp` status checks
- persisted token and settings

### `log_viewer.html`

Offline log inspection tool for large log files.

Features:

- open local files, paste text, drag and drop files
- worker-based parsing with progress updates
- support for common application and browser log formats
- multiline entry parsing
- line-level highlighting by log level
- include and exclude pattern search
- regex search mode
- level filtering
- modal views for stack traces and multiline payloads
- virtualized rendering for large files
- refresh from disk for files opened through the File System Access picker
- overview rail / scroll map
- copy and export of filtered output
- persisted UI settings

## Examples

The [`examples`](./examples) directory contains supporting assets and sample material for some tools. For example, `examples/log_viewer` contains helper content for the log viewer workflow.

## How To Use

1. Open any tool HTML file directly in a browser.
2. Load a local file or paste content into the tool.
3. Work entirely in-browser. No server is required.

## Notes

- This repository intentionally favors simple distribution over framework tooling.
- Browser support is best in modern Chromium-based browsers, especially for features that refresh files directly from disk.
- Some tools persist UI state in `localStorage`.
