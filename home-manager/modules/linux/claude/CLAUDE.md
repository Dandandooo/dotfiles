# Machine context

This machine runs **NixOS**, configured declaratively from `~/.dotfiles` (flake + home-manager).

- **Don't assume common interpreters/tools are installed.** `python`, `python3`, `node`, `pip`, `jq`, etc. are usually *not* on `PATH`. Don't reach for them by default.
- **Editing files: use the built-in file tools** (Read / Edit / Write, or the editor's native edit tool). Never write a Python/Node/sed script just to modify a file when a direct edit works.
- If a tool genuinely is needed for a one-off, run it ephemerally instead of installing it: `nix shell nixpkgs#python3 -c python3 ...` or `nix-shell -p jq --run '...'`. Check with `command -v <tool>` first if unsure.
- Never use `pip install`, `npm install -g`, `apt`, etc. to install things globally — that doesn't work (or isn't wanted) on NixOS. Permanent packages belong in the nix config in `~/.dotfiles`.
- Paths like `/usr/bin/<tool>` mostly don't exist; use `#!/usr/bin/env <tool>` shebangs. Only `/bin/sh` and `/usr/bin/env` are guaranteed.
- Projects may provide a dev shell (`flake.nix` / `shell.nix` / `.envrc`); prefer `nix develop` over installing dependencies by hand.
