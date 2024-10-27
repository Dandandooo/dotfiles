{
  description = "Dandandooo's Dotfiles";

  inputs = {
    nixospkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-colors.url = "github:misterio77/nix-colors";

    nix-darwin.url = "github:LnL7/nix-darwin";

    home-manager.url = "github:nix-community/home-manager";

    flake-utils.url = "github:numtide/flake-utils";

    ags.url = "github:Aylur/ags";
    matugen.url = "github:InioX/matugen";
    
    nixvim.url = "github:nix-community/nixvim";

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    zen-browser.url = "github:MarceColl/zen-browser-flake";

    hyprcursor.url = "github:hyprwm/hyprcursor";
    hyprland.url = "github:hyprwm/hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

  };

  outputs = { nixpkgs, nixospkgs, home-manager, nix-colors, ... } @ inputs: {
    nixosConfigurations = {
      nixxie = nixospkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos/nixxie-hardware.nix
          nixos/configuration.nix
          inputs.minegrub-theme.nixosModules.default
          inputs.minegrub-world-sel-theme.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          { environment.systemPackages = [
              inputs.zen-browser.packages.x86_64-linux.specific
          ]; }
        ];
        specialArgs = { inherit inputs; inherit nix-colors; };
      };
      applenix = nixospkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          nixos/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "dani@brick" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [ 
          home-manager/home.nix
          { 
            home.homeDirectory = "/Users/dani";
            home.sessionVariables.PATH = "$PATH:/opt/homebrew/bin";
          }
        ];
        extraSpecialArgs = { inherit nix-colors; inherit inputs; };
      };
      "dani@nixxie" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [ 
          home-manager/home.nix
          home-manager/modules/linux
        ];
        extraSpecialArgs = { inherit nix-colors; inherit inputs; };
      };
      "dani@applenix" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-linux"; };
        modules = [ 
          home-manager/home.nix
          home-manager/modules/linux
        ];
        extraSpecialArgs = { inherit nix-colors; inherit inputs; };
      };
    };
  };
}
