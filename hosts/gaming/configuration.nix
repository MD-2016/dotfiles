{
  config,
  pkgs,
  user,
  ...
}: {

    # Display and Desktop 
    services.xserver.gdm.enable = true;
    services.xserver.cinnamon.enable = true;

    # enable sound with pipewire
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

    };

    # User account
    users.users.${user}.packages = with pkgs; [
        steam
        heroic
        bottles
        lutris
      ];

}