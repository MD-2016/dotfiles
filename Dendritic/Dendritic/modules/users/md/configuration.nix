{ inputs, ... }:
let
  username = "md";
in
{
  flake.modules.nixos."${username}" =
    { ... }:
    {

      home-manager.users."${username}" = {
        imports = [
          inputs.self.modules.homeManager."${username}"
        ];
      };

      users.users."${username}" = {
        isNormalUser = true;
        initialPassword = "changeplease";
        extraGroups = [
          "networkmanager"
          "wheel"
          "systemd-journal"
          "libvirtd"
          "audio"
          "video"
        ];
      };
    };
}
