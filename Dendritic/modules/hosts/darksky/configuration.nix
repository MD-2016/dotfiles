{ inputs, ... }:
{
  flake.modules.nixos.darksky = {
    networking.hostName = "darksky";

    imports = with inputs.self.modules.nixos; [
      system-desktop
    ];

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      system-desktop
    ];
  };
}
