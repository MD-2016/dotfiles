{ ... }:
{
  flake.modules.nixos.md-CLI = { pkgs, ... }:
    let
      spottyMonitor = import ./_spotty.nix {inherit pkgs;};
    in 
   {
    environment.systemPackages = with pkgs; [
      spottyMonitor
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
      nixd
      nixfmt
      nh
      cachix
      devenv
      wlogout
    ];
  };
}
