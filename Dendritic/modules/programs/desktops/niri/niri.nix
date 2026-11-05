{pkgs, ...}: 
{
  flake.modules.nixos.niri = {...}: 
  {
    programs.niri = 
      {
        enable = true;
        package = pkgs.niri;
      };
  };

  flake.modules.homeManager.niri = {...}: 
  {
    home.packages = with pkgs; 
    [
      mako
      rofi-wayland
    ];
  };
}