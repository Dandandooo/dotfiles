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
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, home-manager, nix-colors, ... }: {
    # let inherit (self) outputs;
      # systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      # forAllSystems = nixpkgs.lib.genAttrs systems;
    # in {
    
    defaultPackage.aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;
    defaultPackage.aarch64-linux = home-manager.defaultPackage.aarch64-linux;
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;


    nixosConfigurations = {
      nixxie = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
        ];
      };
      # goat = nixpkgs.lib.nixosSystem {
        # system = "aarch64-darwin";
        # modules = [
          # ./nixos/configuration.nix
        # ];
      # };
    };

    homeConfigurations = {
      "dani@brick" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [ 
          .config/home-manager/home.nix
        ];
        extraSpecialArgs = { inherit nix-colors; };
      };
      "dani@nixxie" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [ 
          .config/home-manager/home.nix
        ];
        extraSpecialArgs = { inherit nix-colors; };
      };
      "dani@applenix" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [ 
          .config/home-manager/home.nix
        ];
        extraSpecialArgs = { inherit nix-colors; };
      };
    };
  };
}
