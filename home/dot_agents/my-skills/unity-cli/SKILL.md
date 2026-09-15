---
name: unity-cli
description: >
  Unity game development with unity-cli — use this skill whenever the user is working in a Unity project,
  editing Unity scenes or prefabs (including YAML edits), using the unity-cli tool, debugging via the Unity
  console, running Unity tests, writing Unity C# scripts, or asking about Unity Editor workflows, best practices,
  or asset organization. Invoke for any Unity-related task even if the user doesn't mention unity-cli explicitly —
  the CLI is the primary way to validate changes and interact with a running Editor instance.
allowed-tools: Bash(unity-cli:*), Read, Edit, Write, Grep, Glob
---

# Unity Skill

## Overview

unity-cli is a Go CLI binary that controls a running Unity Editor instance via HTTP. It pairs with a C# UPM package (unity-connector) that runs a local HTTP server at `localhost:8090`. The CLI sends one-shot HTTP POST requests per command — there is no persistent process.

The CLI is the primary tool for:
- Validating YAML edits to scenes/prefabs (via `reserialize`)
- Checking for compile or import errors (via `console`)
- Triggering Editor operations without touching the mouse
- Running tests programmatically

---

## unity-cli Command Reference

### Prerequisites

Unity must be open with the unity-connector UPM package installed. If `unity-cli status` times out or errors, Unity is not running or the connector is not installed.

**Install connector** via Package Manager → Add package from git URL:
```
https://github.com/youngwoocho02/unity-cli.git?path=unity-connector
```

**Recommended**: Disable Editor Throttling — Edit → Preferences → General → Interaction Mode → No Throttling.

### Global Flags

| Flag | Description |
|---|---|
| `--project <path>` | Target a specific Unity project (when multiple are open) |
| `--port <N>` | Target by heartbeat port |
| `--timeout <ms>` | HTTP timeout (default: 120000) |
| `--ignore-version-mismatch` | Continue if CLI/Connector versions differ |

### `editor` — Editor lifecycle

```bash
unity-cli editor play            # Enter play mode
unity-cli editor play --wait     # Enter play mode, block until fully loaded
unity-cli editor stop            # Exit play mode
unity-cli editor pause           # Toggle pause (play mode only)
unity-cli editor refresh         # Refresh/reimport assets
unity-cli editor refresh --compile   # Refresh and recompile scripts
unity-cli editor refresh --force     # Force refresh even during play mode
```

### `console` — Read Unity logs

```bash
unity-cli console                          # Read errors and warnings (default)
unity-cli console --lines 50              # Last N log entries
unity-cli console --type error            # Errors only
unity-cli console --type warning          # Warnings only
unity-cli console --filter error,warning,log
unity-cli console --stacktrace user       # Include user-code stack traces
unity-cli console --clear                 # Clear the console
```

After any YAML edit or asset change, always run `unity-cli console --type error` to surface import failures before assuming success.

### `reserialize` — Validate and normalize Unity YAML

```bash
unity-cli reserialize                           # Reserialize entire project
unity-cli reserialize Assets/Scenes/Main.unity  # One file
unity-cli reserialize Assets/Prefabs/Player.prefab
```

This is the primary validation tool for YAML edits. It tells Unity to load the asset through its normal pipeline and write it back out through its own serializer — fixing malformed indentation, missing fields, and stale fileIDs. Run this after every text-based edit to a `.unity`, `.prefab`, `.asset`, or `.mat` file.

### `exec` — Run arbitrary C# in the Editor

```bash
unity-cli exec "return Application.dataPath;"
unity-cli exec "return GameObject.FindObjectsOfType<Camera>().Length.ToString();"
echo 'return Selection.activeObject?.name ?? "nothing selected";' | unity-cli exec
unity-cli exec --usings "UnityEngine.SceneManagement" "return SceneManager.GetActiveScene().name;"
```

Use `echo ... | unity-cli exec` (stdin) for multi-line or complex scripts to avoid shell escaping issues.

### `menu` — Invoke Editor menu items

```bash
unity-cli menu "File/Save Project"
unity-cli menu "Assets/Refresh"
unity-cli menu "Edit/Play"
```

### `test` — Run Unity tests

```bash
unity-cli test                          # EditMode tests (default)
unity-cli test --mode PlayMode          # PlayMode tests
unity-cli test --filter MyTestName      # Substring filter
unity-cli test --auto-save-scenes       # Auto-save dirty scenes first
```

### `profiler` — Unity Profiler access

```bash
unity-cli profiler enable               # Start recording
unity-cli profiler disable              # Stop recording
unity-cli profiler status
unity-cli profiler clear
unity-cli profiler hierarchy            # Last frame, top-level data
unity-cli profiler hierarchy --depth 3  # Drill down
unity-cli profiler hierarchy --frames 30 --min 0.5   # Average N frames, threshold ms
```

### `status` — Show Editor state

```bash
unity-cli status   # Project path, version, PID, connection info
unity-cli list     # Show all available tools (built-in + custom)
```

---

## Safe YAML Editing Workflow

Unity serializes scenes (`.unity`), prefabs (`.prefab`), and other assets (`.asset`, `.mat`) as YAML when the project uses **Force Text** serialization (Edit → Project Settings → Editor → Asset Serialization → Force Text).

### The safe edit loop

1. **Edit** the YAML file in a text editor
2. **Reserialize** to let Unity validate and normalize it:
   ```bash
   unity-cli reserialize Assets/Scenes/MyScene.unity
   ```
3. **Check for errors**:
   ```bash
   unity-cli console --type error
   ```
4. **Refresh** if you need Unity to fully reimport:
   ```bash
   unity-cli editor refresh
   ```
5. Repeat if there are errors.

If `reserialize` produces an error or the console shows import failures, the YAML is malformed. Undo the edit and try again — Unity's YAML parser is strict.

### Unity YAML structure

Unity YAML uses a superset of standard YAML with Unity-specific extensions:

```yaml
%YAML 1.1
%TAG !u! tag:unity3d.com,2011:
--- !u!1 &1234567890
GameObject:
  m_ObjectHideFlags: 0
  m_CorrespondingSourceObject: {fileID: 0}
  m_PrefabInstance: {fileID: 0}
  m_PrefabAsset: {fileID: 0}
  serializedVersion: 6
  m_Component:
  - component: {fileID: 1234567891}
  m_Name: MyObject
  m_TagString: Untagged
  m_IsActive: 1
```

Key concepts:
- `--- !u!<classID> &<fileID>` — document separator; classID identifies the component type; fileID is a unique local identifier
- `{fileID: X}` — local reference within the same file (fileID must exist in the file)
- `{fileID: X, guid: Y, type: Z}` — cross-file reference; guid matches the `.meta` file of the target asset; a null reference is `{fileID: 0}`
- `m_` prefix — Unity convention for serialized fields (from Mono's serialization era)

### What you can safely edit

- **Component field values** — numbers, strings, booleans, vector fields (e.g., `m_LocalPosition`, `m_IsActive`)
- **Adding components** — create a new YAML document block with a unique fileID and add it to the GameObject's `m_Component` list
- **Reordering component order** — edit the `m_Component` list
- **Prefab overrides** — fields in a `PrefabInstance` component

### What to be careful with

- **fileIDs must be unique within the file** — when adding new objects or components, pick a large random integer that doesn't exist elsewhere in the file. Unity often uses 8-12 digit integers.
- **Never change a GUID** — GUIDs live in `.meta` files and are the permanent identity of an asset. Changing a GUID in a cross-file reference breaks every other asset that references it.
- **Cross-file references require the correct guid** — find it in `Assets/<filename>.meta`, under `guid:`.
- **`m_Father` and transform hierarchy** — a Transform's `m_Father` must point to another Transform's fileID in the same scene/prefab. Getting this wrong corrupts the hierarchy.
- **Prefab structure** — prefab files have stricter requirements around the `PrefabInstance` root; prefer editing individual component fields rather than restructuring the prefab hierarchy via YAML.

### Common pitfalls

- **Indentation errors** — Unity YAML uses 2-space indentation. Tabs will break parsing.
- **Duplicate fileIDs** — always search the file for your chosen fileID before using it.
- **Missing `---` separator** — each Unity object must have its own `--- !u!<classID> &<fileID>` header.
- **Wrong classID** — the classID in `!u!<classID>` must match the component type (e.g., `!u!114` for MonoBehaviour, `!u!4` for Transform, `!u!1` for GameObject). Getting it wrong causes silent failures or incorrect deserialization.
- **Editing during Play mode** — avoid editing YAML files while Unity is in Play mode; the Editor won't pick up changes until you stop and reimport.

### Common Unity classIDs

| ClassID | Component |
|---|---|
| 1 | GameObject |
| 4 | Transform |
| 20 | Camera |
| 23 | MeshRenderer |
| 33 | MeshFilter |
| 54 | Rigidbody |
| 65 | BoxCollider |
| 114 | MonoBehaviour |
| 136 | RectTransform |
| 212 | SpriteRenderer |
| 224 | RectTransform (UI) |
| 1001 | PrefabInstance |

---

## Unity Best Practices

### When to edit YAML directly vs. use the Editor

**Use the Editor (via `exec` or menu commands) for:**
- Creating or deleting GameObjects
- Reparenting objects in the hierarchy
- Adding/removing components on many objects
- Anything involving GUID lookup or complex references

**Edit YAML directly for:**
- Bulk field changes across many objects (script-driven)
- Removing a specific component from a deeply nested prefab
- Changing serialized field defaults that the Editor UI doesn't expose
- Applying consistent values across many prefabs in CI

### Checking for problems after changes

After any edit cycle, run this sequence:
```bash
unity-cli reserialize <file>          # Let Unity normalize
unity-cli console --type error        # Check for import errors
unity-cli editor refresh --compile   # Recompile if scripts changed
unity-cli console --type error        # Check for compile errors
```

### Running tests before shipping

```bash
unity-cli test                        # EditMode
unity-cli test --mode PlayMode        # PlayMode (requires clean scene state)
```

If tests rely on scene state, use `--auto-save-scenes` to avoid dirty-scene failures.

### Using `exec` for scripted Editor operations

`exec` is the escape hatch for anything not covered by a built-in command. Treat it like a REPL for the Unity Editor:

```bash
# Get all scene names
unity-cli exec "return string.Join(\", \", UnityEditor.EditorBuildSettings.scenes.Select(s => s.path));" \
  --usings "System.Linq"

# Count objects with a specific component
unity-cli exec "return GameObject.FindObjectsOfType<Rigidbody>().Length.ToString();"

# Trigger a custom menu item
unity-cli menu "Tools/My Custom Build Script"
```

### Targeting multiple open projects

```bash
ls ~/.unity-cli/instances/          # See running instances
unity-cli --project ~/projects/MyGame editor play
unity-cli --port 8091 editor play
```

### Custom tools (project-specific commands)

Teams can register custom CLI commands in C# using `[UnityCliTool]`:

```csharp
[UnityCliTool(Name = "spawn", Description = "Spawn an enemy at position", Group = "gameplay")]
public static class SpawnEnemy
{
    public class Parameters { public float x; public float y; public float z; }
    public static object HandleCommand(JObject parameters) { /* ... */ }
}
```

These appear in `unity-cli list` and are invoked as `unity-cli spawn --x 1 --y 0 --z 5`.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `unity-cli` command times out | Unity not running or connector not installed | Open Unity, install connector package |
| Version mismatch error | CLI and Connector versions differ | Update both or use `--ignore-version-mismatch` |
| `reserialize` succeeds but errors appear in console | YAML is structurally valid but semantically wrong (bad reference, wrong classID) | Check console output, review the specific field |
| Console shows no output after edit | Unity hasn't reimported yet | Run `unity-cli editor refresh` |
| Changes not visible in Play mode | Assets changed while in Play mode | Stop play mode, refresh, then re-enter |
