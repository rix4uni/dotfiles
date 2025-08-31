## Setup

- `.wezterm.lua` Works with tmux.
- `.wezterm2.lua` Does not works with tmux this have many feature of tmux, if you don't want to use tmux then use this.

## 🟢 Windows (PowerShell)
In Windows, WezTerm looks for config at:
`$env:USERPROFILE\.wezterm.lua` (e.g., `C:\Users\rix4uni\.wezterm.lua`)

So run in **PowerShell**:
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/rix4uni/dotfiles/refs/heads/main/wezterm/.wezterm.lua" -OutFile "$env:USERPROFILE\.wezterm.lua"
```

## 🟢 Ubuntu (WSL)
WezTerm under WSL typically uses Linux paths (`~/.config/wezterm/wezterm.lua`).

Run:
```bash
mkdir -p ~/.config/wezterm
wget -q https://raw.githubusercontent.com/rix4uni/dotfiles/refs/heads/main/wezterm/.wezterm.lua -O ~/.config/wezterm/wezterm.lua
```

👉 That way you’ll have:
* Windows: `C:\Users\rix4uni\.wezterm.lua`
* WSL/Linux: `~/.config/wezterm/wezterm.lua`
