{ ... }:
{
  flake.modules.nixos.hyprland =
    { pkgs,... }:
    {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = false;
      };

       environment.systemPackages = with pkgs; [
        grim
        wl-clipboard
        slurp
        jq
        master.linux-wallpaperengine
      ];

    };

    flake.modules.homeManager.hyprland = 
      {pkgs, ...}: 
      {    

            fonts.fontconfig.enable = true;
            home.packages = [ pkgs.nerd-fonts.jetbrains-mono pkgs.font-awesome  ];
            xdg = {
              enable = true;
              mime.enable = true;
              portal = {
                enable = true;
                extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
                configPackages = [ pkgs.hyprland ];
              };
            };
    };
}
