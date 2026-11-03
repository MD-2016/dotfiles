{ ... }:
{
  flake.modules.nixos.aquatic-cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
      ];
    };

  flake.modules.homeManager.aquatic-cli = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "MD-2016";
          email = "programforcoffee89@gmail.com";
        };
        fetch.prune = true;
      };
    };
  };
}