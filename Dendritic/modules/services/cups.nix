{ ... }:
{
  flake.modules.nixos.cups =
    { pkgs, ... }:
    {
      services.printing.enable = true;

      environment.systemPackages = with pkgs; [
        brlaser
        hplip
      ];
    };
}
