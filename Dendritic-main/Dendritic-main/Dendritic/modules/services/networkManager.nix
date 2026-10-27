{ ... }:
{
  flake.modules.nixos.networkManager = {
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.powersave = false;
  };
}
