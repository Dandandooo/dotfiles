{ config, ... }:

{
  # Global instructions for every Claude Code instance (CLI, Zed agent, etc.).
  # Out-of-store symlink so edits (including Claude's own /memory edits) land
  # in the repo without a home-manager switch.
  home.file.".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/.dotfiles/home-manager/modules/linux/claude/CLAUDE.md";
}
