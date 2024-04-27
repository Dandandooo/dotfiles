{
  description = "Dandandooo's Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    defaultPackage.aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;

    homeConfigurations = {
      dani = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [ .config/home-manager/home.nix ];
      };
    };
  };
}
