# DO-NOT-EDIT. This file was auto-generated using github:denful/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs; }
  {
    imports = [
      ./core.nix
      (inputs.import-tree ./modules)
    ];
  };


  inputs = {

      AquaticOS = {
        url = "git+https://git.aquaticservers.com/aqua/AquaticOS";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.nixpkgs-master.follows = "nixpkgs-master";
        inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
        inputs.flake-file.follows = "flake-file";
        inputs.flake-parts.follows = "flake-parts";
        inputs.home-manager.follows = "home-manager";
        inputs.import-tree.follows = "import-tree";
        inputs.nur.follows = "nur";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
