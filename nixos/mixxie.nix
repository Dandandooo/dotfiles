# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./mixxie-hardware.nix
      ./general.nix
      ./modules/servers
      ./modules/login.nix
    ];

  ###### MACHINE SPECIFIC ######
  time.timeZone = "America/New_York";
  networking.hostName = "mixxie";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ###### USERS ######

  users.users.dani = {
    isNormalUser = true;
    description = "Daniel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };


  ###### MANAGEMENT ###### 
  # Nightly reboot at 03:30 (minecraft servers get a graceful `stop` via their systemd units)
  systemd.timers.nightly-reboot = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 03:30:00";
      Persistent = false;
    };
  };
  systemd.services.nightly-reboot = {
    serviceConfig.Type = "oneshot";
    script = "${pkgs.systemd}/bin/systemctl reboot";
  };

  # Nothing is open to the internet by default. SSH is reachable only over Tailscale
  # (tailscale0 is trusted). Game/map ports are opened per-service (minecraft-servers.openFirewall).
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
    trustedInterfaces = [ "tailscale0" ];
  };
  services.openssh.openFirewall = false;
  programs.steam.remotePlay.openFirewall = lib.mkForce false;

  services.tailscale.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
      "amd_pstate=active" # Zen 3 Freq scaler
      "amdgpu.ppfeaturemask=0xffffffff" # iGPU power/clock control
      # "amdgpu.runpm=0" # Disables GPU power management
      # "panic=10" # Reboots 10 seconds after panic
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd # opencl for 5700g
      mesa
      libGL
    ];
  };

  powerManagement.cpuFreqGovernor = "performance";

  zramSwap = {
    enable = true;
    memoryPercent = 10;
    algorithm = "lz4";
    priority = 999;
  };

  fileSystems."/".options = [
    "noatime" # don't log access time (good for MC)
    "nodiratime"
    "commit=10" # save every 10s instead of 5s
  ];

  ###### NIXOS ######
  system.stateVersion = "23.11"; # no touch
}
