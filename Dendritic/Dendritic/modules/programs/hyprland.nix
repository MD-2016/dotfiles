{ pkgs, ... }:
{
  flake.modules.nixos.hyprland =
    { ... }:
    {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = false;
      };
    };

  xdg.configFile."hypr" = {
    source = ./hypr;
    recursive = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];

    config.common.default = [
      "hyprland"
      "gtk"
    ];
  };
}
