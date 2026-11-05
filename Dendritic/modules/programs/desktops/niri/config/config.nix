{ ... }:  
{
  flake.modules.homeManager.niri = {...}: 
  {
    home.file.".config/niri/config.kdl".source = ./config.kdl;
  };
}