{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    tmux

    git
    gh

    kitty
    discord
    firefox
    prismlauncher

    # System status
    lm_sensors
    amdgpu_top
    neofetch
    btop

    hyprpaper
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  programs.hyprland.enable = true;
  programs.zsh.enable = true;

  # Keys only. Port 22 is still open on all interfaces (no tailscale on this host yet).
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "dani" ];
      X11Forwarding = false;
      MaxAuthTries = 3;
      LoginGraceTime = 20;
    };
  };
  users.users.dani.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAkz2eu9QqRZ5oJ31Le7TR5Iwc1n69Tjt/ghjCIgQCX dani@brick"
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
