{ ... }:
{
  flake.modules.homeManager.hyprland = {
    programs.waybar = {
      enable = true;

      style = ''
        * {
          font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
          font-size: 13px;
          font-weight: bold;
          min-height: 0;
        }

        window#waybar {
          background: transparent;
          color: #cdd6f4;
        }

        /* --- MODULE CONTAINERS (Pills) --- */
        .modules-left,
        .modules-center,
        .modules-right {
          background: rgba(30, 30, 46, 0.85);
          border: 2px solid rgba(137, 180, 250, 0.4);
          border-radius: 16px;
          padding: 4px 10px;
          margin-top: 6px;
          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
        }

        /* --- INDIVIDUAL MODULE STYLING --- */
        #workspaces {
          background: transparent;
          margin: 0 4px;
        }

        #workspaces button {
          padding: 0 8px;
          color: #6c7086;
          border-radius: 10px;
          transition: all 0.3s ease-in-out;
        }

        #workspaces button.active {
          background: linear-gradient(135deg, #89b4fa, #cba6f7);
          color: #11111b;
          font-weight: bolder;
          box-shadow: 0 0 10px rgba(137, 180, 250, 0.6);
        }

        #workspaces button:hover {
          background: #313244;
          color: #f5e0dc;
        }

        #window {
          color: #fab387;
          padding: 0 10px;
        }

        #cpu, #memory, #temperature, #pulseaudio, #backlight, #battery, #network, #clock {
          padding: 0 8px;
          margin: 0 2px;
          border-radius: 8px;
          transition: background 0.2s ease;
        }

        #cpu:hover, #memory:hover, #temperature:hover, #pulseaudio:hover, #backlight:hover, #battery:hover, #network:hover {
          background: rgba(255, 255, 255, 0.1);
        }

        #cpu { color: #89b4fa; }
        #memory { color: #a6e3a1; }
        #temperature { color: #f9e2af; }
        #temperature.critical {
          color: #f38ba8;
          animation: blink 1s infinite alternate;
        }

        #pulseaudio { color: #f5c2e7; }
        #backlight { color: #fab387; }
        #battery { color: #a6e3a1; }
        #battery.charging { color: #a6e3a1; }
        #battery.critical:not(.charging) {
          color: #f38ba8;
          animation: blink 1s infinite alternate;
        }

        #network { color: #89dceb; }

        #clock {
          color: #b4befe;
          font-weight: bold;
        }

        #custom-power {
          color: #f38ba8;
          padding: 0 6px 0 10px;
          font-size: 15px;
        }

        @keyframes blink {
          to {
            background-color: #f38ba8;
            color: #11111b;
          }
        }

      '';

      settings = [
        {
          layer = "top";
          position = "top";
          height = 36;
          margin-top = 6;
          margin-left = 10;
          margin-right = 10;
          spacing = 4;

          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "cpu"
            "memory"
            "temperature"
            "pulseaudio"
            "backlight"
            "network"
            "battery"
            "custom/power"
          ];

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            format = "{icon}";
            format-icons = {
              "1" = "";
              "2" = "󰖟";
              "3" = "󰓓";
              "4" = "󰉋";
              "5" = "󰎆";
              urgent = "";
              focused = "";
              default = "";
            };
          };

          "hyprland/window" = {
            format = "{}";
            max-length = 35;
            separate-outputs = true;
          };

          clock = {
            format = "󰥔 {:%H:%M   %d %b}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "󰥔 {:%Y-%m-%d}";
          };

          cpu = {
            format = "󰻠 {usage}%";
            interval = 2;
            tooltip = false;
          };

          memory = {
            format = "󰍛 {}%";
            interval = 5;
          };

          temperature = {
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-icons = [
              "󰔏"
              "󰔏"
              "󰔏"
            ];
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-bluetooth = "{icon} {volume}%";
            format-muted = "󰖁 Muted";
            format-icons = {
              headphone = "󰋋";
              hands-free = "󣠰";
              headset = "󰋎";
              phone = "󰏲";
              portable = "󰏲";
              car = "󰄋";
              default = [
                "󰕿"
                ""
                "󰕾"
              ];
            };
            on-click = "pavucontrol";
          };

          backlight = {
            format = "{icon} {percent}%";
            format-icons = [
              "󰃞"
              "󰃟"
              "󰃠"
            ];
          };

          network = {
            format-wifi = "󰖩 {essid}";
            format-ethernet = "󰈀 Wired";
            format-disconnected = "󰖪 Disconnected";
            tooltip-format = "{ifname} via {gwaddr}";
            max-length = 20;
          };

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󰚥 {capacity}%";
            format-alt = "{icon} {time}";
            format-icons = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };

          "custom/power" = {
            format = "󰐥";
            tooltip = false;
            on-click = "wlogout"; # Or your preferred power menu launcher
          };
        }
      ];
    };
  };
}
