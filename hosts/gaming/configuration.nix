{
  config,
  pkgs,
  user,
  ...
}: {
   # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking and host
    networking.hostName = "darknet"

    # Enable Systemd Network Manager
    networking.networkmanager.enable = true;

    # Set Time Zone
    time.timeZone = "America/New_York";

    # internationalisation prop
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extractLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # enable X11 windowing
    services.xserver.enable = true;

    # Display and Desktop 
    services.xserver.gdm.enable = true;
    services.xserver.cinnamon.enable = true;

    # keymap
    services.xserver = {
      layout = "us";
      xkbVariant = "";
    };

    # printing
    services.printing.enable = true;

    # enable sound with pipewire
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

    };

    # User account
    users.users.${user} = {
      isNormalUser = true;
      description = "MD Cool";
      extraGroups = ["networkmanager" "wheel" "audio"]
      packages = with pkgs; [
        firefox
        pkgs.ungoogled-chromium
        pkgs.steam
        pkgs.heroic
        pkgs.bottles
        pkgs.lutris
        pkgs.discord
      ];
    };

    # Services
    services.flatpak.enable = true;

    # Allow unfree
    nixpkgs.config.allowUnfree = true;

    # Flakes
    nix.extraOptions = "experimental-features = nix-command flakes";

    # System wide packages
    environment.systemPackages = with pkgs; [
        micro
        git
        pkgs.pavucontrol
    ];

     # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?


}