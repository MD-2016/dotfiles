{ ... }: 
{
    flake.modules.nixos.md-programs = {
      { pkgs, ... }: {
          environment.systemPackages = with pkgs; [
        (writeShellApplication {
         name = "nixos-age";

         runtimeInputs = [ coreutils ];

         text = ''
            birth_install=$(stat --format=%W /nix/var/nix/profiles/system)

            if [ "$birth_install" -eq 0 ] || [ -z "$birth_install" ]; then
                birth_install=$(stat --format=%W /)
            fi

            current=$(date +%s)
            time_progression=$((current - birth_install))
            days_difference=$((time_progression / 86400))

            echo "$days_difference days"    
         '';
     })

     (writeShellApplication {
         name = "time-left";

         runtimeInputs = with pkgs; [
             coreutils
             gnugrep
             gawk
         ];

         text = ''
            START_DATE=$(stat / | grep Birth | awk '{print $2" "$3"}')
            END_SEC=$(date -d "''${START_DATE} +1 year" +%s)
            NOW_SEC=$(date +%s)

            REMAINING=$((END_SEC - NOW_SEC))

            if [ "''${REMAINING}" -le 0 ]; then
                echo "Run Ended!"
                exit 0
            fi

            DAYS=$((REMAINING / 86400))
            HOURS=$(((REMAINING % 86400) / 3600))
            MINUTES=$(((REMAINING % 3600) / 60))

            echo "''${DAYS} d ''${HOURS} h ''${MINUTES} m left" 
         '';     
     })
          ];
      };
    };
}
