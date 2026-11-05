{pkgs, ... }: 
{
  flake.modules.nixos.noctalia = 
    {
      programs.noctalia = 
        {
          enable = true;

          settings = 
            {
              bar = 
                {
                  position = "top";
                  widgets = 
                    {
                      left = ["launcher" "workspaces" "windowTitle"];
                      right = ["volume" "battery" "clock" "tray"];
                    };
                };
                theme = 
                  {
                    variant = "dark";
                    primaryColor = "#7aa2f7";
                  };
            };
        };
    };
}