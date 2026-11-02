{lib, pkgs, ... }: 
{
  flake.modules.nixos.displayManager = {pkgs, ...}:
    {
      services.greetd = 
        {
          enable = true;
          settings = 
            {
              default_session = 
                {
                  user = "greeter";
                  command = "${lib.getExe pkgs.tuigreet}";
                };
            };
        };
    };
}