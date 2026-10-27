{ inputs, ... }:
{
  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-base
      ssh
      md-CLI
      shell
      cups
      flatpak
      git
      development
    ];
  };

  flake.modules.homeManager.system-cli = {
    imports = with inputs.self.modules.homeManager; [
      system-base
    ];
  };
}
