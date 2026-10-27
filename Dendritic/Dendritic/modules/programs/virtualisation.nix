{ ... }:
{
  flake.modules.nixos.virtualisation =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        virt-manager
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
    };
}
