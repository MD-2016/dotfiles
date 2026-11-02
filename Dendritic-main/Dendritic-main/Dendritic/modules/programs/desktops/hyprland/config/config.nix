{ ... }: 
{
  flake.modules.homeManager.hyprland = { ... }: 
  {
    home.file.".config/hypr/hyprland.lua".source = ./hyprland.lua;
    home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  };
}