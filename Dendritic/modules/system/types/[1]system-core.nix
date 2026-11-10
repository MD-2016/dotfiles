{ inputs, ... }:
{
  flake.modules.nixos.system-core =
    { ... }:
    {
      imports = with inputs.self.modules.nixos; [
        core_system-core
      ];
      services.automatic-timezoned.enable = false;
      time.timeZone = "America/New_York";
      nixpkgs.config.allowUnfree = true;
    };
}