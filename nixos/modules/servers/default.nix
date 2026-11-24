{ config, pkgs, lib, nix-minecraft, ... }:

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
        # /run/minecraft is created by systemd (RuntimeDirectory) for each server unit.
        # Attach with: sudo -u lunchbox tmux -S /run/minecraft/<name>.sock attach
        socketPath = name: "/run/minecraft/${name}.sock";
      };
    };
    user = "lunchbox";
    group = "minecraft";
  };

  # Service account only: no password, no login shell, no home.
  users.users.lunchbox = {
    isSystemUser = true;
    group = "minecraft";
    description = "Minecraft Server";
  };
  users.groups.minecraft = { };

  # Extra sandboxing on top of nix-minecraft's defaults: the whole filesystem is
  # read-only to the server except its own data dir (and /run/minecraft).
  systemd.services = lib.mapAttrs' (name: _: lib.nameValuePair "minecraft-server-${name}" {
    serviceConfig = {
      ProtectSystem = "strict";
      ReadWritePaths = [ "${config.services.minecraft-servers.dataDir}/${name}" ];
      NoNewPrivileges = true;
    };
  }) (lib.filterAttrs (_: s: s.enable) config.services.minecraft-servers.servers);
}
