{ ... }:
{
  flake.modules.nixos.nixos = {
          fileSystems."/" =
    { device = "/dev/disk/by-uuid/56653e5f-8f09-4be9-9368-2c5decd627c9";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3804-4C4B";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/5f5852ce-a2a4-4758-8b2e-3122150aca8c"; }
    ];
    };
  }
