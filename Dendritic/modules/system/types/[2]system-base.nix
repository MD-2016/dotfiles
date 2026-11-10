{ inputs, ... }:
{
  flake.modules.nixos.system-base = {
    imports = with inputs.self.modules.nixos; [
      system-core
      environment
      networkManager
      md
      avahi
      core_home-manager
    ];
  };

  flake.modules.homeManager.system-base = {
    imports = with inputs.self.modules.homeManager; [
      core_home-manager
    ];
  };
}
