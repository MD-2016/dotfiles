{ ... }: 
{
  flake.modules.nixos.git = { pkgs, ... }: 
  {
    environment.systemPackages = with pkgs; 
    [
      git
    ];
  };

  flake.modules.homeManager.git = 
    {
      programs.git = 
        {
          enable = true;
          settings = 
            {
              user = 
                {
                  name = "MD-2016";
                  email = "25043596+MD-2016@users.noreply.github.com";
                };
                fetch.prune = true;
            };
        };
    };
}