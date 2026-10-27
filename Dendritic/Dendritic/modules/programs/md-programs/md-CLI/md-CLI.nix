{ ... }:
{
  flake.modules.nixos.md-CLI = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      micro
      wget
      unzip
      zip
      curl
      vim
      jq
      gh
      fastfetch
      opencode
      python3
      rustc
      go
      zig
      ruby
    ];
  };
}
