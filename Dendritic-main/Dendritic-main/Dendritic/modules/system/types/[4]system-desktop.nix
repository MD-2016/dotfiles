{ inputs, ... }:
{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli
      md-GUI
      kitty
      virtualisation
      dbus
      pipewire
      xkb
      hyprland
      linux-cachyos
      mango
      displayManager
      xfce
      cosmic
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-cli
      kitty
      hyprland
      firefox
      mango
    ];
  };
}
