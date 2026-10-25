{ inputs, ... }:
{
  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-base
      ssh
      md-CLI
    ];
  };

  flake.modules.homeManager.system-cli = {
    imports = with inputs.self.modules.homeManager; [
      system-base
    ];
  };
}
