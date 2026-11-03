{ ... }: 
{
  flake.modules.homeManager.firefox = { ... }:
    {
      programs.firefox = 
        {
          enable = true;

          profiles.default = 
            {
              id = 0;
              name = "Default";
              isDefault = true;

              settings = 
                {
                  "toolkit.legacyUserProfileCustomization.stylesheets" = true;

                  "browser.theme.dark-system-prefs" = true;
                  "ui.systemUsesDarkTheme" = 1;

                  "general.smoothScroll" = true;
                };

                userChrome = ''
                  :root {
                    --toolbar-bgcolor: #18181b;
                  }

                  #urlbar-background {
                    border-radius: 8px !important;
                    background-color: #27272a !important;
                  }
                '';
            };

         policies = {
            ExtensionSettings = {
                "ublock0@raymondhill.net" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                };

                "{73452E0A-5283-41ac-83RE-3F72D4C89EFF}" = {};
            };
          };
        };
    };
}