{ inputs, ... }:
{
  flake.modules.nixos.nixos = {
    networking.hostName = "nixos";

    imports = with inputs.self.modules.nixos; [
      system-desktop
    ];

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      system-desktop
    ];
  };
}
