{
  description = "Example Home Manager Configuration for NixOS Minimal";
  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/*";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.2411.*";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "https://flakehub.com/f/nixos/nixpkgs/0.2411.*";
  };
  outputs =
    { self, ... }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "24.11";
      helper = import ./lib { inherit inputs outputs stateVersion; };
    in
    {
      # home-manager build --flake .#nixos@nixos -L
      homeConfigurations = {
        "nixos@nixos" = helper.mkHome { };
      };
    };
}
