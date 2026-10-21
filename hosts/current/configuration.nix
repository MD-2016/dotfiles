# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

let
	spottyMonitor = import ./spotty.nix { inherit pkgs; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

    programs.mangowc.enable = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];
      
    # Global Environment Variables
    environment.sessionVariables = {
      HISTCONTROL = "ignoreboth";
      HISTSIZE = "1000";
      HISTFILESIZE = "2000";
      EDITOR = "vim";
      VISUAL = "vim";
      QML_IMPORT_PATH = "/usr/local/lib64/qt6/qml:\${QML_IMPORT_PATH:-}";
      # export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
      # export GOROOT=/usr/lib64/go1.26.5/go
      # export GOPATH=$HOME/go
      # export PODMAN=/usr/local/bin/podman
    };
  
    # Append directory paths to the system-wide $PATH environment variable
    environment.profiles = [
      "/home/md/.cargo/bin"
      "/usr/local/sbin"
      "/home/md/awww/target/release/"
      # "/home/md/zig/zig-x86_64-linux-0.16.0/"
      # "/home/md/zls/"
      # "$GOPATH/bin"
      # "$PODMAN"
      # "/home/md/typst/typst-x86_64-unknown-linux-musl/"
      # "/home/md/nb/nb-7.25.2/"
    ];

    programs.dconf.enable = true;
  
    # System-wide Bash Configuration
    programs.bash = { 
      # Global Shell Aliases
      shellAliases = {
        # Custom workflow updates for configuration.nix
        micbash = "sudo micro /etc/nixos/configuration.nix";
        srcb = "sudo nixos-rebuild switch";
        
        # General aliases
        "~" = "cd ~";
        c = "cd";
        ".." = "cd ..";
        mkd = "mkdir -p";
        clr = "clear";
        hcw = "history -c && history -w";
        dmg = "sudo dmesg";
        logout = "gnome-session-quit";
        suspend = "systemctl suspend";
        ffx = "(firefox &> /dev/null &)";
        ff = "fastfetch -c ~/.config/fastfetch/config.jsonc";
        vnst = "sudo virsh net-start default";
  
        # Flatpak specific
        bottles = "(flatpak run com.usebottles.bottles &> /dev/null &)";
        wolf = "(flatpak run io.gitlab.librewolf-community &> /dev/null &)";
        discord = "(discord  &>  /dev/null &)";
        hexchat = "(flatpak run io.github.Hexchat &> /dev/null  &)";
        element = "(flatpak run im.riot.Riot &> /dev/null &)";
        shortwave = "(flatpak run de.haeckerfelix.Shortwave &> /dev/null &)";
        seal = "(flatpak run com.github.tchx84.Flatseal &> /dev/null &)";
        imgview = "(flatpak run org.gnome.Loupe &> /dev/null &)";
        pdesk = "(flatpak run io.podman_desktop.PodmanDesktop &> /dev/null &)";
        boxbuddy = "(flatpak run io.github.dvlv.boxbuddyrs &> /dev/null &)";
        lunacy = "(flatpak run com.icons8.Lunacy &> /dev/null &)";
        obsidian = "(flatpak run md.obsidian.Obsidian &> /dev/null &)";
        flatup = "flatpak update";
  
        top = "htop";
        notes = "micro";
        search = "apt search";
  
        # Debian specific
        add = "sudo apt install";
        remove = "sudo apt remove";
        distup = "sudo apt dist-upgrade";
        update = "sudo apt update";
        upgrade = "sudo apt upgrade";
        full = "sudo apt full-upgrade";
        purge = "sudo apt purge";
        show = "apt show";
        aplist = "apt list";
        autoremoove = "sudo apt autoremove";
        lsbugs = "apt-listbugs";
        clrcb = "xclip -sel clip < /dev/null";
        spotm = "cd ~/.config/fastfetch/ && ./spotty.sh";
  
        # Slackware Commands
        slackup = "sudo slackpkg update";
        slackrm = "sudo slackpkg remove";
        slackin = "sudo slackpkg install";
        slackupga = "sudo slackpkg upgrade-all";
        slackpkgupg = "sudo slackpkg upgrade";
        slackpkginn = "sudo slackpkg install-new";
        slackpkggpg = "sudo slackpkg update gpg";
  
        # Sway
        vsw = "vim .config/sway/config";
  
        # Distrobox specific
        distent = "distrobox enter";
        pacup = "sudo pacman -Syu";
        y = "yay";

        # Nixos
        micronixc = "sudo micro /etc/nixos/configuration.nix";
        micronixf = "sudo micro /etc/nixos/flake.nix";
        micronixh = "sudo micro /etc/nixos/home.nix";
        micros = "sudo micro";
        nixswitch = "sudo nixos-rebuild switch";
        
  
        # Commented out aliases
        # shopt -s globstar
        # podman = "podman";
        # ll = "ls -l";
        # la = "ls -A";
        # l = "ls -CF";
        # search = "pacman -Ss";
        # office = "(flatpak run org.libreoffice.LibreOffice &> /dev/null &)";
        # spotify = "(flatpak run com.spotify.Client &> /dev/null &)";
        # dquilt = "quilt --quiltrc=\${HOME}/.quiltrc-dpkg";
      };
  
      # Script hooks appended to the system interactive shell initialization (/etc/bashrc)
      interactiveShellInit = ''
        # Custom functions
        pacupy() {
            pacup && y
        }
  
        updg() {
            update && upgrade
        }
  
        musicfetch() {
            spotm && ff
        }
  
        scrollback=5000
  
        # enable programmable completion features
        if ! shopt -oq posix; then
          if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
          elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
          fi
        fi
  
        #. "/home/md/.cargo/env"
      '';
    };

      
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
  	enable = true;
  	wifi.powersave = false;
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # display manager for cosmic sees the sessions
  services.displayManager.sessionPackages = [ pkgs.mangowc];

  # Enable the Budgie Desktop environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.cosmic-greeter.enable = false;
  services.desktopManager.cosmic.enable = true;
  services.xserver.desktopManager.budgie.enable = false;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.printing.drivers = with pkgs; [
    	brlaser
    	hplip
    ];
  

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."md" = {
    isNormalUser = true;
    description = "MD";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "audio" "video" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  
  services.avahi = {
  	enable = true;
  	nssmdns4 = true;
  	openFirewall = true;
  };

  services.flatpak.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     vim
     wget
     shortwave
     discord
     ungoogled-chromium
     git
     libreoffice
     micro
     curl
     vim
     spotify
     cups
     hplip
     fastfetch
     gimp
     kitty
     mangowc
     noctalia
     waybar
     vscodium
     nerd-fonts.jetbrains-mono
     unzip
     zip
     mousepad
     virt-manager
     dconf-editor
	 spottyMonitor
	 gh
	 rofi
	 swaylock
	 awww
	 opencode
	 mupen64plus
					
     (writeShellApplication {
     	name = "nixos-age";

     	runtimeInputs = [ coreutils ];

     	text = ''
			birth_install=$(stat --format=%W /nix/var/nix/profiles/system)

			if [ "$birth_install" -eq 0 ] || [ -z "$birth_install" ]; then
				birth_install=$(stat --format=%W /)
			fi

			current=$(date +%s)
			time_progression=$((current - birth_install))
			days_difference=$((time_progression / 86400))

			echo "$days_difference days"	
     	'';
     })

     (writeShellApplication {
     	name = "time-left";

     	runtimeInputs = with pkgs; [
     		coreutils
     		gnugrep
     		gawk
     	];

     	text = ''
			START_DATE=$(stat / | grep Birth | awk '{print $2" "$3"}')
			END_SEC=$(date -d "''${START_DATE} +1 year" +%s)
			NOW_SEC=$(date +%s)

			REMAINING=$((END_SEC - NOW_SEC))

			if [ "''${REMAINING}" -le 0 ]; then
				echo "Run Ended!"
				exit 0
			fi

			DAYS=$((REMAINING / 86400))
			HOURS=$(((REMAINING % 86400) / 3600))
			MINUTES=$(((REMAINING % 3600) / 60))

			echo "''${DAYS} d ''${HOURS} h ''${MINUTES} m left"
     	'';     
     })
   ];

   

   virtualisation.libvirtd = {
   		enable = true;
   		qemu = {
   			package = pkgs.qemu_kvm;
   			runAsRoot = true;
   			swtpm.enable = true;
   		};
   };

   virtualisation.spiceUSBRedirection.enable = true;

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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
