{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix # only works in impure ! :(((
    ];

  ##########  BOOT  ##########
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    minegrub-theme = {
      enable = false;
      splash = "100% Flakes!";
      boot-options-count = 4;
    };
    minegrub-world-sel = {
      enable = true; 
      customIcons = [{
	      name = "nixos";
        lineTop = "Nixxie";
        lineBottom = "Survival Mode, No Cheats, Version: ${config.system.nixos.release}";
        imgName = "nixos";
      }];
    };
    device="nodev";
    useOSProber = true; # detect windows
  };
  # boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];


  ########## NETWORKING ##########
  networking.hostName = "nixxie";
  networking.networkmanager.enable = true;

  ########## BLUETOOTH ##########
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  ########## SOUND ##########
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
    extraGroups = [ "networkmanager" "wheel" "docker" "i2c" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   backupFileExtension = "backup";
  #   users.dani = import ../home-manager/home.nix;
  # };

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
    docker

    # Music
    # spotify # managed by stylix

    # vcs
    git
    gh

    # browsers
    firefox

    # Utilities
    curl
    nmap
    tree
    wget
    unzip
    syncthing
    playerctl
    i2c-tools
    
    # Terminal
    kitty
    warp-terminal

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
    openrgb-with-all-plugins
    waybar
    eww
    wofi

    bibata-cursors
    gsettings-desktop-schemas
    glib

    # Notifications
    dunst

    # File explorer
    # dolphin

    # Java
    zulu8

    # Screen Capture
    grim
    slurp
  ];


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  # programs.vscode.enable = true;

  programs.zsh.enable = true;

  # darn british people
  virtualisation.docker.enable = true;

  ########## OpenRGB ##########
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
  # services.udev.packages = [ pkgs.openrgb ];
  # hardware.i2c.enable = true;

  hardware.keyboard.qmk.enable = true;

  ########## THEMING ##########
  fonts = {
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      nerd-fonts.martian-mono
      nerd-fonts.agave
    ];
    fontDir.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  ########## NIXOS ##########
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11"; # no touch
}
