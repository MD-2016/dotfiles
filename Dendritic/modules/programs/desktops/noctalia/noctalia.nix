{inputs, ...}: 
{
  flake.modules.nixos.noctalia = {pkgs, ...}: 
    {
     
      environment.systemPackages = with pkgs; 
      [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };

      flake.modules.homeManager.noctalia = 
    {

       imports = [
        inputs.noctalia.homeModules.default
      ];

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