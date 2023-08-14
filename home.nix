# home-manager specific config
{...}: {
  # Programs Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
