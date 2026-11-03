{ inputs, ... }: 
{
  flake.modules.md-GUI = { pkgs, ...}: 
  {
    environment.systemPackages = 
      [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
  };
}