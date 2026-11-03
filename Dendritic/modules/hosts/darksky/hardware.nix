{ ... }:
{
  flake.modules.nixos.darksky = {
    boot.initrd.availableKernelModules = [
      "xhci_pci" 
      "ahci" 
      "nvme" 
      "usb_storage" 
      "usbhid" 
      "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];
  };
}
