{ ... }:
{
  flake.modules.nixos.md-GUI = { pkgs, ... }: 
    let
      spottyMonitor = import ./_spotty.nix { inherit pkgs; };
    in
  {
    environment.systemPackages = with pkgs; [
      shortwave
      discord
      ungoogled-chromium
      libreoffice
      spotify
      cups
      hplip
      gimp
      waybar
      vscodium
      nerd-fonts.jetbrains-mono
      mousepad
      virt-manager
      dconf-editor
      spottyMonitor
      gh
      rofi
      swaylock
      awww
      hyprpaper
      btop
      font-awesome
      hyprpicker
      grimblast
      wine
      wine64
    ];

    programs.firefox.enable = true;

    programs.dconf.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
