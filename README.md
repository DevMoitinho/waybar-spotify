# Waybar-Spotify
 
A lightweight [Waybar](https://github.com/Alexays/Waybar) module that shows the song currently playing on Spotify as a smooth, scrolling text.
 
<!-- Add a screenshot or GIF here: -->
<!-- ![Preview](assets/preview.gif) -->
 
## Features
 
- Scrolling `title - artist` text while a track is playing
- Static `⏸ title - artist` display when playback is paused
- Single shell script, no daemon and no extra config files
- Easy to tweak: scroll speed and text width are plain command-line flags
## Requirements
 
| Dependency | Purpose |
| --- | --- |
| [Waybar](https://github.com/Alexays/Waybar) | Status bar |
| [zscroll](https://github.com/noctuid/zscroll) | Text scrolling |
| [playerctl](https://github.com/altdesktop/playerctl) | Reads the Spotify player state |
| [Spotify](https://www.spotify.com/) | Music player (any client that exposes MPRIS under the name `spotify`) |
 
## Installation
 
1. Clone the repository (or copy directly from /src/waybar-spotify.sh into a file):
```bash
   git clone https://github.com/<your-user>/waybar-spotify.git
   cd waybar-spotify
```
 
2. Copy the script to your Waybar scripts folder and make it executable:
```bash
   mkdir -p ~/.config/waybar/scripts
   cp waybar-spotify.sh ~/.config/waybar/scripts/
   chmod +x ~/.config/waybar/scripts/waybar-spotify.sh
```
 
3. Add the module to your Waybar config (`~/.config/waybar/config.jsonc`):
```jsonc
   {
       "modules-center": ["custom/spotify"],
 
       "custom/spotify": {
           "exec": "$HOME/.config/waybar/scripts/waybar-spotify.sh",
           "format": "{}",
           "tooltip": false
       }
   }
```
 
4. (Optional) Style it in `~/.config/waybar/style.css`:
```css
   #custom-spotify {
       padding: 0 10px;
       color: #1db954;
   }
```
 
5. Restart Waybar:
```bash
   pkill waybar && waybar &
```
 
## Customization
 
All options live in the `zscroll` call inside `waybar-spotify.sh`:
 
| Flag | Default | Description |
| --- | --- | --- |
| `--length` | `10` | Number of characters visible at once |
| `--delay` | `0.1` | Seconds between scroll steps (lower is faster) |
| `--before-text` | `⏸` | Prefix shown while paused |
| `-p` | `"  "` | Separator displayed between loops of the text |
 
## Troubleshooting
 
**The script works in the terminal but not when Waybar is started by the compositor.**
 
Waybar launched from your session (autostart, systemd, etc.) does not read your interactive shell configuration, so it may not find `zscroll` in its `PATH`. This is common when `zscroll` is installed with `pip --user`, `pipx` or conda/miniforge.
 
- Find where it is installed: `command -v zscroll`
- Add that directory to the `export PATH=...` line at the top of `waybar-spotify.sh`, or use the absolute path to `zscroll`.
**The module is empty or shows `faltando: <command>`.**
 
A dependency is missing from the `PATH`. Check that both `zscroll` and `playerctl` are installed and reachable.
 
**`playerctl` does not detect Spotify.**
 
Run `playerctl -l`. If `spotify` is not listed, make sure Spotify is running and that Waybar has access to your D-Bus session (`DBUS_SESSION_BUS_ADDRESS` and `XDG_RUNTIME_DIR` must be set in its environment).
 
## Contributing
 
Issues and pull requests are welcome. If you found a bug or have an idea, feel free to open an issue.
 
## License
 
Distributed under the MIT License. See [`LICENSE`](LICENSE) for details.
