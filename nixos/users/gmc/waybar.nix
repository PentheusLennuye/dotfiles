{ pkgs, config, lib, waybarStyle, ... }:

{
  # Totally stolen from Zaney 
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [{
      layer = "top";
      position = "top";

      modules-left = [ "hyprland/window" ];
      modules-center = [ "network" "temperature" "pulseaudio" "cpu" "memory" "disk" "clock" "custom/germany" ];
      modules-right = [ "idle_inhibitor" "custom/notification" "tray" ];
      "hyprland/workspaces" = {
      	format = "{icon}";
      	format-icons = {
          default = " ";
          active = " ";
          urgent = " ";
      	};
      	on-scroll-up = "hyprctl dispatch workspace e+1";
      	on-scroll-down = "hyprctl dispatch workspace e-1";
      };
      "clock" = {
        format = "{: %I:%M %p}";
      	tooltip = false;
      };
      "custom/germany" = {
        exec = "TZ=':CET' date +'%I:%M %p'";
        format = " {}";
      	tooltip = false;
        interval = 60;
      };
      "memory" = {
      	interval = 5;
      	format = " {}%";
        tooltip = true;
      };
      "cpu" = {
      	interval = 5;
      	format = " {usage:2}%";
        tooltip = true;
      };
      "disk" = {
        format = "  {free}";
        tooltip = true;
      };
      "network" = {
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        format-ethernet = ": {bandwidthDownOctets}";
        format-wifi = "{icon} {signalStrength}%";
        format-disconnected = "󰤮";
        tooltip = false;
      };
      "temperature" = {
        format = "{temperatureC}";
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
          default = ["" "" ""];
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
        format = "{icon} {}";
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
        on-click = "task-waybar";
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
        format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        on-click = "";
        tooltip = false;
      };
    }];
    style = ''
	* {
		font-size: 16px;
		font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
    		font-weight: bold;
	}
	window#waybar {
          background-color: rgba(26,27,38,0);
          border-bottom: 1px solid rgba(26,27,38,0);
          border-radius: 0px;
	}
	#workspaces {
		background: linear-gradient(180deg, #9e9e9e, #9e9e9e);
    		margin: 5px;
    		padding: 0px 1px;
    		border-radius: 15px;
    		border: 0px;
    		font-style: normal;
	}
	#workspaces button {
    		padding: 0px 5px;
    		margin: 4px 3px;
    		border-radius: 15px;
    		border: 0px;
    		opacity: 1.0;
    		transition: all 0.3s ease-in-out;
	}
	#workspaces button.active {
    		border-radius: 15px;
    		min-width: 40px;
    		transition: all 0.3s ease-in-out;
    		opacity: 1.0;
	}
	#workspaces button:hover {
    		border-radius: 15px;
    		opacity: 1.0;
	}
	tooltip {
  		border-radius: 10px;
	}
	tooltip label {
	}
	#window {
                background-color: #9e9e9e;
                color: #ffffff;
    		border-radius: 0px 15px 50px 0px;
    		margin: 5px 5px 5px 0px;
    		padding: 2px 20px;
	}
	#memory {
                background-color: #33cc33;
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#clock {
                background-color: #cccccc;
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#custom-germany {
                background-color: #999999;
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#idle_inhibitor {
                background-color: #000000;
                color: #ffffff;
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#cpu {
                background-color: #ffa500;
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#disk {
                background-color: #6666ff;
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#battery {
    		border-radius: 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#network {
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#tray {
                background-color: #000000;
    		border-radius: 15px 0px 0px 50px;
    		margin: 5px 0px 5px 5px;
    		padding: 2px 20px;
	}
	#pulseaudio {
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#idle_inhibitor {
                background-color: #000000;
                color: #ffffff;
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#cpu {
                background-color: #ffa500;
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#disk {
                background-color: #6666ff;
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#battery {
    		border-radius: 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#network {
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#tray {
                background-color: #000000;
    		border-radius: 15px 0px 0px 50px;
    		margin: 5px 0px 5px 5px;
    		padding: 2px 20px;
	}
	#pulseaudio {
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#custom-notification {
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#temperature {
                background-color: #cc3333;
    		border-radius: 15px 0px 0px 50px;
    		margin: 5px 0px 5px 5px;
    		padding: 2px 20px;
	}
    '';
  };
}
