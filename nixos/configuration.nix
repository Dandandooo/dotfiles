{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # /etc/nixos/hardware-configuration.nix # only works in impure ! :(((
      # <home-manager/nixos>
    ];

  ##########  BOOT  ##########
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    minegrub-theme = {
      enable = false;
      splash = "100% Flakes!";
      boot-options-count = 4;
    };
    minegrub-world-sel = {
      enable = true; 
      customIcons = [{
	      name = "nixos";
        lineTop = "NixOS";
        lineBottom = "Survival Mode, No Cheats, Version: ${config.system.nixos.release}";
        imgName = "nixos";
      }];
    };
    device="nodev";
    # font="${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/HeavyDataNerdFont-Regular.ttf";
  };
  # boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
  # boot.plymouth.enable = true; # DO NOT


  ########## NETWORKING ##########
  networking.hostName = "nixxie";

  # Enable networking
  networking.networkmanager.enable = true;

  ########## BLUETOOTH ##########
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  ########## SOUND ##########
  # sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # playerctl defined in environment packages

  ########## LOCALES ##########
  # Set your time zone.
  time.timeZone = "America/Chicago";

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

  ########## USERS ##########

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dani = {
    isNormalUser = true;
    description = "Dani";
    extraGroups = [ "networkmanager" "wheel" "docker" "i2c"];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  ########## WINDOW MANAGER ##########
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # TODO: Add hyprlock lock screen
  # TODO: Add screen sharing ability
  # TODO: set up screen capture

  # Hint Electron apps to use wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-46.0/";
  };

  # For Screen sharing
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  ########## PACKAGES ##########

  nixpkgs.config.allowUnfree = true; 
  environment.systemPackages = with pkgs; [
    # Text Editors
    vim

    # IDEs
    jetbrains-toolbox
    vscode

    # Development
    dotnet-sdk_8
    docker
    nodejs

    # Music
    spotify

    # vcs
    git
    gh
    stow

    # browsers
    firefox

    # Utilities
    wget
    curl
    tree
    unzip
    neofetch
    syncthing
    playerctl
    
    # Terminal
    zsh
    kitty
    warp-terminal
    btop

    # Games
    lutris
    prismlauncher
    protonup

    # Social
    discord
    slack

    # Productivity
    obsidian
    zoom-us
    boxfs

    # Desktop
    hyprpaper
    hyprlock
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    waybar
    eww
    wofi

    bibata-cursors
    gsettings-desktop-schemas
    glib

    # Notifications
    dunst

    # File explorer
    dolphin

    # Java
    zulu8
  ];


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  # programs.vscode.enable = true;

  programs.fish.enable = false;
  programs.zsh.enable = true;
  # users.defaultUserShell = pkgs.fish;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  ########## OpenRGB ##########
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
  # services.udev.packages = [ pkgs.openrgb ];
  # hardware.i2c.enable = true;

  ########## THEMING ##########
  fonts = {
    packages = with pkgs; [
      nerdfonts
    ];
    fontDir.enable = true;
  };
  # console.font = "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/CaskaydiaCoveNerdFont-Bold.ttf";
  # console.font = "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/HeavyDataNerdFont-Regular.ttf";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  ########## NIXOS ##########

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
