{ inputs, ... }:
{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli
      md-GUI
      virtualisation
      dbus
      pipewire
      xkb
      hyprland
      linux-cachyos
      displayManager
      xfce
      cosmic
      niri
      noctalia
      dms
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-cli
      hyprland
      firefox
      niri
      noctalia
    ];
  };
}
