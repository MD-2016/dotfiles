{ ... }: 
{
  flake.modules.homeManager.hyprland = { ... }: 
  {
    home.file.".config/hypr/hyprland.lua".source = ./hyprland.lua;
  };
}