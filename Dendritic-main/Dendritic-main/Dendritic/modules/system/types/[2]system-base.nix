{ inputs, ... }:
{
  flake.modules.nixos.system-base = {
    imports = with inputs.self.modules.nixos; [
      system-core
      home-manager
      environment
      nur
      networkManager
      md
      avahi
    ];
  };

  flake.modules.homeManager.system-base = {
    imports = with inputs.self.modules.homeManager; [
      system-core
      nur
    ];
  };
}
