{ config, pkgs, lib, ... }:

{
    imports = [
        ./shells.nix
        ./troll.nix
        ./starship.nix
    ];

    home.packages = with pkgs; [
        ### Shells
        xonsh

        ### System information
        fastfetch
        onefetch

        ### File Utility
        miller
        dust
        tree
        stow
        cloc

        ### Vibes
        claude-code
        codex
    ];
    
    home.file = {
        ".xonshrc".text = "execx($(starship init xonsh))";
    };

    programs.kitty = {
        enable = true;
        settings = {
            term = "xterm-256color";
            dynamic_background_opacity = "yes";
            background_opacity = lib.mkForce 0.85;
            background_blur = 64;

            font_size = lib.mkDefault 15.0;
            bold_font = "auto";

            # kitty newer than 0.46.2 restores its saved "maximized" state on launch, which covers other tiled windows
            remember_window_size = "no";
        };
    };

    home.sessionVariables = {

    };

    # programs.codex = {
    #     enable = true;
    #     settings = {
    #         personality = "pragmatic";
    #         features = {
    #             rmcp_client = true;
    #         };
    #
    #         mcp_servers = {
    #             context7 = {
    #                 command = "${pkgs.nodejs}/bin/npx";
    #                 args = [ "-y" "@upstash/context7-mcp@latest" ];
    #             };
    #         };
    #
    #     };
    # };
}
