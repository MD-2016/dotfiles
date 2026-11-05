{...}: 
{
  flake.modules.nixos.niri = {pkgs, ...}: 
  {

    environment.systemPackages = with pkgs; 
    [
      xwayland-satellite
    ];

    programs.niri = 
      {
        enable = true;
        package = pkgs.niri;
      };
  };

  flake.modules.homeManager.niri = {pkgs, ...}: 
  {
    home.packages = with pkgs; 
    [
      mako
      rofi
    ];
  };
}