{ inputs, ... }:
{
  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-base
      ssh
      md-CLI
      shell
      cups
    ];
  };

  flake.modules.homeManager.system-cli = {
    imports = with inputs.self.modules.homeManager; [
      system-base
    ];
  };
}
