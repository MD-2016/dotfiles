{ ... }:
{
    flake.modules.nixos.md-programs = {
      { pkgs, ...}: {
          environment.systemPackages = with pkgs [
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
          ];
      };
    };
}