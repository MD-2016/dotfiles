{ inputs, ... }:
{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli
      md-programs
      kitty
      virtualisation
      dbus
      pipewire
      xkb
      xserver
      hyprland
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-cli
      kitty
      hyprland
    ];
  };
}
