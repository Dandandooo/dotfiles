{ config, pkgs, ... }:

{
    services.minecraft-servers.servers = let 
        _serverProperties = {
            difficulty = 2;

            white-list = true;
            enforce-whitelist = true;
            online-mode = true;

            motd = "ts is vanilla bro";

            render-distance = 18;
            simulation-distance = 10;

            spawn-protection = 0;
        };
        _whitelist = {
            Dandandooo = "559ce80a-b083-4a31-95a6-4329d03270c5";
            Huppup = "17d01342-ba76-48f9-94ce-cfd9bdd22e13";
            TheGraecus = "6b10d977-1c39-477d-8b71-b7be17d13fda";
            Major_Weneral = "dea66c5c-2437-4c57-8cf7-53b2e918e5ba";
        };
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
    };

}
