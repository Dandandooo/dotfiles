{ config, nix-minecraft, pkgs, nixpkgs, ... }:

{
  imports = [
    nix-minecraft.nixosModules.minecraft-servers
    ./rlcraft.nix
    ./lbthieves.nix
  ];

  nixpkgs.overlays = [
    nix-minecraft.overlay
  ];

  environment.systemPackages = with pkgs; [
    # Java builds
    graalvmPackages.graalvm-oracle # JDK 25
    graalvmPackages.graalvm-oracle_17 # JDK 17
    zulu8 # JDK 8
    # zulu17
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    dataDir = "/minecraft/servers";
    managementSystem = {
      systemd-socket = {
        enable = true;
      };
      tmux = {
        enable = false;
        socketPath = name: "/minecraft/run/${name}.sock";
      };
    };
    user = "lunchbox";
    group = "minecraft";
  };
}
