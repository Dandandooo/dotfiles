{ config, pkgs, ... }:

{
    services.minecraft-servers.servers = let 
        _serverProperties = {
            difficulty = 2;

            white-list = true;
            enforce-whitelist = true;
            online-mode = true;
            enforce-secure-profile = true;

            motd = "ts is vanilla bro";

            render-distance = 18;
            simulation-distance = 10;

            spawn-protection = 0;
        };
        _whitelist = import ./whitelist.nix;
        _jvmOpts = "-Xmx8G -Xms4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1";
        basePort = 2500;
    in {
        paper-21_11 = {
            enable = true;
            autoStart = false;
            package = pkgs.paperServers.paper-1_21_11;
            whitelist = _whitelist;
            serverProperties = {
                server-port = basePort + 1;
            } // _serverProperties;
            jvmOpts = _jvmOpts;
        };

        paper-21_1 = {
            enable = true;
            autoStart = false;
            package = pkgs.paperServers.paper-1_21_1;
            whitelist = _whitelist;
            serverProperties = {
                server-port = basePort + 2;
            } // _serverProperties;
            jvmOpts = _jvmOpts;
        };

        paper-26_3 = {
            enable = true;
            autoStart = false;
            package = pkgs.paperServers.paper-26_3;
            whitelist = _whitelist;
            serverProperties = {
                server-port = basePort + 3;
            } // _serverProperties;
            jvmOpts = _jvmOpts;
            # Symlink individual jars (not the whole plugins/ dir) so plugins
            # can still create their own config/data folders next to them.
            # squaremap's web UI listens on :8080 (reachable over tailscale).
            symlinks = {
                # LOD streaming for Voxy clients (a.k.a. "LOD Server Support")
                "plugins/voxy-server-side.jar" = pkgs.fetchurl {
                    url = "https://cdn.modrinth.com/data/84zcagOb/versions/eJEdGL97/voxy-server-side-paper.jar";
                    sha512 = "6701cb8c868d5f9e2b6f2a991a7fdb00f631a9d5fb9f508cb9b472d3892b7f39a6d94b3147f1374e93b26e2af41c9cad130785a151390b2aa217808222547fd5";
                };
                # LOD streaming for Distant Horizons clients.
                # NOTE: 0.14.0 officially targets <= 26.2; no 26.3 build yet.
                "plugins/DistantHorizonsSupport.jar" = pkgs.fetchurl {
                    url = "https://cdn.modrinth.com/data/IjY7seTG/versions/R1UjEyjz/DistantHorizonsSupport-0.14.0.jar";
                    sha512 = "b210b81df67ee36fa048406096fbc90805af81d978d6aa53f0bda91f4120d76b1b4fe6367b980b3c2036eac233c30cf86f881cf5c574b809c8635607c9ff991a";
                };
                # Web map
                "plugins/squaremap.jar" = pkgs.fetchurl {
                    url = "https://cdn.modrinth.com/data/PFb7ZqK6/versions/YqUtyFYN/squaremap-paper-mc26.3-1.4.4.jar";
                    sha512 = "77fe28a4d669fcfc6e2ff83655086799e599f43d031b140f58b61eca76b70040664b54282b63dda5fd457a28d3b967eadd7f7bea47f7be61118e1e6ea8d91bba";
                };
                # Chunk pre-generation
                "plugins/Chunky.jar" = pkgs.fetchurl {
                    url = "https://cdn.modrinth.com/data/fALzjamp/versions/RBuKjN4k/Chunky-Paper-1.5.66.jar";
                    sha512 = "c67b14569b8624d8d4ca550f0a064703e144d388073b4c34a913c3bd34ea39351bef504542101d7f85b499b4de95c24d027a62ee64aad3f9a7051ae4bec80c52";
                };
            };
        };
    };

}
