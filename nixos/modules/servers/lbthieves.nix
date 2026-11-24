{ config, pkgs, lib, nix-minecraft, ... }:

{
  services.minecraft-servers.servers.lbthieves2 = let
    modpack = pkgs.fetchPackwizModpack {
      url = "https://raw.githubusercontent.com/Dandandooo/lbthieves2/master/pack.toml";
      packHash = "sha256-42YwWQVdcrAo8UNZCo8uZoW2AKHw+XPzIPRoPDTyTMY=";
      side = "server";
    };
    mcVersion = modpack.manifest.versions.minecraft;
    fabricVersion = modpack.manifest.versions.fabric;
    serverVersion = lib.replaceStrings [ "." ] [ "_" ] "fabric-${mcVersion}";
  in
    {
      enable = true;
      package = pkgs.fabricServers.${serverVersion}.override { loaderVersion = fabricVersion; };
      symlinks = {
        "mods" = "${modpack}/mods";
      };
      # Copy (not symlink) configs so mods can still write to them.
      # Guarded: collectFilesAt errors if the pack has no config/ dir.
      files = lib.optionalAttrs (builtins.pathExists "${modpack}/config")
        (nix-minecraft.lib.collectFilesAt modpack "config");
      autoStart = false;
      whitelist = import ./whitelist.nix;
      jvmOpts = "-Xmx8G -Xms6G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1";
      serverProperties = {
        # World
        pvp = true;
        difficulty = "hard";
        gamemode = "survival"; 
        level-name = "second_lunchbox";
        spawn-protection = 1;

        # Server
        motd = "§o§7Return of the Thieves§r";
        snooper-enabled = false;

        # Security
        white-list = true;
        enforce-whitelist = true;
        online-mode = true;
        enforce-secure-profile = true;

        # Connection
        server-port = 2301;
        enable-rcon = false;

        # Performance
        simulation-distance = 7;
        view-distance = 13;
      };
    };
}
