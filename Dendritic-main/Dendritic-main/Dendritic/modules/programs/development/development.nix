{ ... }:
{
  flake.modules.nixos.development = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      python3
      rustc
      go
      zig
      ruby
      cachix
      devenv
    ];
  };
}
