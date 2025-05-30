{
  description = "Dandandooo's Dotfiles";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
    matugen.url = "github:InioX/matugen";

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";

    zen-browser.url = "github:MarceColl/zen-browser-flake";
    firefox.url = "github:nix-community/flake-firefox-nightly";

    hyprcursor.url = "github:hyprwm/hyprcursor";
    hyprland.url = "github:hyprwm/hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

  };

  outputs = { nixpkgs, stylix, home-manager, ... } @ inputs: {
    nixosConfigurations = {
      nixxie = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.minegrub-theme.nixosModules.default
          inputs.minegrub-world-sel-theme.nixosModules.default
          home-manager.nixosModules.home-manager
          nixos/configuration.nix
          { environment.systemPackages = [
              inputs.zen-browser.packages.x86_64-linux.specific
          ]; }
        ];
        specialArgs = { inherit inputs; };
      };
      applenix = nixpkgs.lib.nixosSystem {
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
          home-manager/modules/macos.nix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
      "dani@nixxie" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [ 
          home-manager/home.nix
          home-manager/modules/linux
        ];
        extraSpecialArgs = { inherit inputs; };
      };
      "dani@applenix" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-linux"; };
        modules = [ 
          home-manager/home.nix
          home-manager/modules/linux
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}
