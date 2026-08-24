{ pkgs, ... }:
let
  colour_a = "#3b68e4";
  colour_c = "#d4a42b";
  white = "#ffffff";
in
{
  # Totally stolen from Zaney
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = [
          "power-profiles-daemon"
          "battery"
          "temperature"
          "cpu"
          "memory"
          "disk"
        ];
        modules-center = [
          "custom/ireland"
          "custom/clock"
          "custom/germany"
          "custom/china"
        ];
        modules-right = [
          "hyprland/workspaces"
          "pulseaudio"
          "idle_inhibitor"
          "custom/notification"
          "tray"
          "network"
        ];
        "hyprland/workspaces" = {
          all-outputs = true;
          disable-scroll = true;
          format = "{icon}";
          format-icons = {
            active = "●";
            default = "○";
            persistent = "○";
            urgent = "⦻";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
          };
        };
        "custom/clock" = {
          exec = "date +'%I:%M %p, %a %b %d'";
          format = "🇨🇦 {text}";
          tooltip = false;
          interval = 15;
        };
        "custom/ireland" = {
          exec = "TZ=':IST' date +'%I:%M %p'";
          format = "🇮🇪 {text}";
          tooltip = false;
          interval = 15;
        };
        "custom/germany" = {
          exec = "TZ=':CET' date +'%I:%M %p'";
          format = "🇩🇪 {text}";
          tooltip = false;
          interval = 15;
        };
        "custom/china" = {
          exec = "TZ=':Asia/Shanghai' date +'%I:%M %p'";
          format = "🇨🇳 {text}";
          tooltip = false;
          interval = 15;
        };
        "memory" = {
          interval = 5;
          format = " {used}/{total}GiB";
          tooltip = true;
        };
        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = true;
        };
        "disk" = {
          format = " {percentage_used}%";
          tooltip = true;
        };
        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = ": {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "temperature" = {
          format = "{temperatureC}°C";
        };
        "tray" = {
          spacing = 12;
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = "true";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon}<span><sup>{0}</sup></span>";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-rignt = "swaync-client -d -sw";
          escape = true;
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
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
          on-click = "";
          tooltip = false;
        };
        "power-profiles-daemon" = {
          format = "󱐋 {icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "󰾅";
            performance = "󰓅";
            balanced = "󰾅";
            power-saver = "󰾆";
          };
        };
      }
    ];
    style = ''
      	* {
            font-size: 12px;
      		  font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
            font-weight: bold;
      	}

      	#window {
            background-color: rgba(200,200,200,50);
          	border-radius: 0px 15px 15px 0px;
          	margin: 2px 2px 2px 0px;
          	padding: 2px 10px;
      	}

      	window#waybar {
            background-color: rgba(26,27,38,0);
            border-bottom: 1px solid rgba(26,27,38,0);
            border-radius: 0px;
      	}

      	tooltip {
        		border-radius: 10px;
      	}

      	tooltip label { }

        /*
         * ╭─────────────────────────────────────────────────────────────────╮
         * │                           Power                                 │
         * ╰─────────────────────────────────────────────────────────────────╯
         */

      	#battery {
            border-radius: 15px;
            color: ${white};
            margin: 2px;
            padding: 2px 10px;
      	}
        #power-profiles-daemon {
            border-radius: 15px;
            color: ${white};
          	margin: 2px;
          	padding: 2px 10px;
      	}

        /*
         * ╭─────────────────────────────────────────────────────────────────╮
         * │                      Hardware Monitoring                        │
         * ╰─────────────────────────────────────────────────────────────────╯
         */

      	#temperature {
            color: ${colour_a};
          	border-radius: 15px 0px 0px 50px;
            margin: 2px;
            padding: 2px 10px;
      	}
      	#cpu {
          	background-color: rgba(0,0,0,0);
            color: ${colour_a};
          	border-radius: 0px 0px 0px 0px;
            margin: 2px;
            padding: 2px 10px;
      	}
      	#memory {
          	background-color: rgba(0,0,0,0);
            color: ${colour_a};
            border-radius: 0px 0px 0px 0px;
            margin: 2px;
            padding: 2px 10px;
      	}
      	#disk {
          	background-color: rgba(0,0,0,0);
            color: ${colour_a};
          	border-radius: 0px 0px 0px 0px;
            margin: 2px;
            padding: 2px 10px;
      	}

        /*
         * ╭─────────────────────────────────────────────────────────────────╮
         * │                      International Time                         │
         * ╰─────────────────────────────────────────────────────────────────╯
         */

      	#custom-ireland {
            color: ${colour_c};
            background-color: #000000;
          	border-radius: 15px 0px 0px 50px;
            margin: 2px;
            padding: 2px 10px;
      	}
      	#custom-clock {
            background-color: #000000;
            border-radius: 0px;
            color: ${colour_a};
            font-size: 14px;
            margin: 2px;
            padding: 2px 10px;
      	}
      	#custom-germany {
            color: ${colour_c};
            background-color: #000000;
            border-radius: 0px;
            margin: 2px;
          	padding: 2px 10px;
      	}
      	#custom-china {
            color: ${colour_c};
            background-color: #000000;
          	border-radius: 0px 50px 15px 0px;
          	margin: 2px;
          	padding: 2px 10px;
      	}

        /*
         * ╭─────────────────────────────────────────────────────────────────╮
         * │                       Window Paging                             │
         * ╰─────────────────────────────────────────────────────────────────╯
         */

      	#workspaces {
          	background: rgba(0,0,0,0);
          	border-radius: 0px 5px 5px 0px;
          	border: 0px;
          	font-style: normal;
          	margin: 2px;
          	padding: 2px 10px;
      	}
      	#workspaces button {
            color: ${colour_a};
          	padding: 0px 5px;
          	border-radius: 15px;
          	border: 0px;
          	opacity: 1.0;
          	margin: 2px;
          	padding: 2px 10px;
      	}
      	#workspaces button:hover{
            color: ${colour_a};
          	padding: 0px 5px;
          	border-radius: 15px;
          	border: 0px;
          	opacity: 1.0;
      	}

        /*
         * ╭─────────────────────────────────────────────────────────────────╮
         * │                        Input / Output                           │
         * ╰─────────────────────────────────────────────────────────────────╯
         */

      	#pulseaudio {
            background-color: #000000;
            color: ${white};
          	border-radius: 15px 0px 0px 50px;
          	margin: 2px;
          	padding: 2px 10px;
      	}
      	#idle_inhibitor {
            background-color: #000000;
            color: ${white};
          	border-radius: 0px 0px 0px 0px;
          	margin: 2px;
          	padding: 2px 10px;
      	}
      	#custom-notification {
            background-color: #000000;
            color: ${white};
          	border-radius: 0px 0px 0px 0px;
          	margin: 2px;
          	padding: 2px 10px;
      	}
      	#tray {
            background-color: #000000;
            color: ${white};
          	border-radius: 0px 0px 0px 0px;
          	margin: 2px;
          	padding: 2px 10px;
      	}
      	#network {
            background-color: #000000;
            color: ${white};
          	border-radius: 0px 50px 15px 0px;
          	margin: 2px;
          	padding: 2px 10px;
      	}
    '';
  };
}
