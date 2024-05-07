{
  description = "Dandandooo's Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    nix-colors.url = "github:misterio77/nix-colors";

    nix-darwin.url = "github:LnL7/nix-darwin";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, nix-colors, nix-darwin, ... } @ inputs:
    let
      inherit (self) outputs;

      user = "dani";
      system = "x86_64-linux";

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      overlays = import ./overlays { inherit inputs; };

      # defaultPackage.aarch64_darwin = home-manager.defaultPackage.aarch64-darwin;

      homeConfigurations = {
        dani = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [ .config/home-manager/home.nix ];
          extraSpecialArgs = { inherit nix-colors; };
        };
      };
    };
}
