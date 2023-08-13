{
    config,
    pkgs,
    user,
    ...
}: {

    # Enable MATE with gdm
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.mate.enable = true;

   

    # Enable sound with pulseaudio
    sound.enable = true;
    hardware.pulseaudio.enable = true;
    security.rtkit.enable = true;

    # Define user account 
        users.users.${user}.packages = with pkgs; [
            # main
            vscode
            inkscape

            # Desktop tools
            gnome.gnome-terminal
            mate.pluma
            mate.mate-utils
            mate.mate-tweak
            mate.mate-themes

        ];
}