{ config, ... }:

{
  # Installs the `quickshell` / `qs` binaries. Hyprland starts `qs` on login
  # (hyprland/default.nix).
  programs.quickshell.enable = true;

  # Out-of-store symlink so ~/.config/quickshell points straight at the repo:
  # quickshell hot-reloads on save, no home-manager switch needed per edit.
  xdg.configFile."quickshell".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/.dotfiles/home-manager/modules/linux/quickshell/config";
}
