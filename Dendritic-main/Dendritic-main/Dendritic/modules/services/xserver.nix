{ ... }:
{
  flake.modules.nixos.xserver =
    { ... }:
    {
      services.xserver.enable = true;
      services.xserver.displayManager.lightdm.enable = true;
      services.desktopManager.cosmic.enable = true;
      services.xserver.desktopManager.xfce.enable = true;
    };
}
