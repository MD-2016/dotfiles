{ ... }: 
{
  flake.modules.nixos.displayManager = 
    {
      services.greetd = 
        {
          enable = true;
          settings = 
            {
              default_session = 
                {
                  user = "greeter";
                  command = getExe' pkgs.tuigreet "tuigreet";
                };
            };
        };
    };
}