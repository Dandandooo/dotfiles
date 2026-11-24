{ config, pkgs, nix-minecraft, ... }:

{
  imports = [
    nix-minecraft.nixosModules.minecraft-servers
    ./lbthieves.nix
    ./paper.nix
  ];

  nixpkgs.overlays = [
    nix-minecraft.overlay
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    dataDir = "/minecraft/servers";
    managementSystem = {
      systemd-socket = {
        enable = false;
      };
      tmux = {
        enable = true;
        socketPath = name: "/minecraft/run/${name}.sock";
      };
    };
    user = "lunchbox";
    group = "minecraft";
  };
}
