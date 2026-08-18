# Example

Bar widget that shows a configurable label and accepts an IPC event to change
it at runtime. Starting point for a new plugin.

## Plugin

| Field | Value |
| --- | --- |
| ID | `tanren/example` |
| Entries | Bar widget: `hello` |

## Usage

Add the `hello` widget from the Add-widget picker. It shows the configured label.

## Settings

| Setting | Type | Default | Description |
| --- | --- | --- | --- |
| `label` | `string` | `Hello` | Text shown in the bar. |

## IPC

```sh
noctalia msg plugin tanren/example:hello focused set "Hi there"
```

`set` replaces the label until the next reload.
