{
  config,
  lib,
  pkgs,
  ...
}:
let
  hostName = lib.removeSuffix "\n" (builtins.readFile /etc/hostname);
  lconfig = ".config/hypr";
in
{
  home.file = {
    "${lconfig}/bg.jpg".source = hypr/bg.jpg;
    "${lconfig}/hypridle.conf".source = hypr/hypridle.conf;
    "${lconfig}/hyprlock.conf".source = hypr/hyprlock.conf;
    "${lconfig}/hyprpaper.conf".source = hypr/hyprpaper.conf;
    "${lconfig}/profile.conf".source = hypr/${hostName}.conf;
    "${lconfig}/toggle_keyboard.sh".source = hypr/toggle_keyboard.sh;
  };

  # ┌──────────────────────────────────────────────────────┐
  # │ Hyprland.conf                                        │
  # └──────────────────────────────────────────────────────┘

  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session.vars.sh";

  wayland.windowManager.hyprland = {
    enable = true;
    package = null; # use the system package
    portalPackage = null; # "
    plugins = [
      pkgs.hyprlandPlugins.hyprgrass
    ];
    settings = {
      source = "~/.config/hypr/profile.conf";

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      decoration = {
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        rounding = 10;
        shadow = {
          color = "rgba(1a1a1aee)";
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true; # you probably want this
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
        enforce_permissions = false;
      };

      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "waybar"
        "hyprpaper"
      ];

      general = {
        allow_tearing = false;
        border_size = 2;
        "col.active_border" = "rgba(595959aa)";
        gaps_in = 5;
        gaps_out = 10;
        layout = "dwindle";
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        key_press_enables_dpms = true;
      };

      windowrulev2 = [
        "workspace 2,class:^(@joplin/app-desktop)$"
        "workspace 3,class:^(code-url-handler)$"
        "workspace 4,class:^(cider)$"
        "workspace 5,class:^(virt-manager)$"
      ];

      # ┌─────────────────────────────────────────────────────────────────────────────────────────────┐
      # │ Keybindings                                                                                 │
      # └─────────────────────────────────────────────────────────────────────────────────────────────┘

      "$mainMod" = "SUPER";
      "$VG" = "~/spaces/entertainment/videogames";
      "$MUSIC" = "~/spaces/entertainment/music";

      bind = [
        "$mainMod SHIFT, E, exit"
        "$mainMod, F, fullscreen"
        "$mainMod, G, exec, appimage-run $VG/appImages/ES-DE_x64.AppImage --home $VG"
        "$mainMod SHIFT, P, exec, grim -g \"$(slurp)\""
        "$mainMod SHIFT, Q, killactive"
        "$mainMod, RETURN, exec, kitty"
        "$mainMod, A, exec, anki"
        "$mainMod, D, exec, wofi -c ~/.config/wofi/wofi.conf"
        "$mainMod, I, exec, firefox"
        "$mainMod SHIFT, J, exec, qjackctl"
        "$mainMod, K, exec, virt-manager"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, M, exec, appimage-run $MUSIC/appImages/cider-linux-x64.AppImage"
        "$mainMod, N, exec, joplin-desktop"
        "$mainMod, O, exec, obsidian"
        "$mainMod, R, exec, firefox --new-instance --profile ~/.mozilla/firefox/eypklzjy.iCloud --kiosk https://icloud.com"
        "$mainMod, Z, exec, zotero"

        # Backscreen light binding
        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"

        # Audio binds
        # WPCtl is "Wireplumber," the control for PipeWire. It is equivalent to PulseAudio's pactl.
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # Standard binds

        "$mainMod, V, togglefloating"
        "$mainMod, P, pseudo" # dwindle
        "$mainMod, J, togglesplit" # dwindle

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces
        "$mainMod SHIFT, right, workspace, e+1"
        "$mainMod SHIFT, left, workspace, e-1"

        # Move/resize windows with mainMod + LMB/RMB
        "$mainMod ALT, right, resizeactive, 20 0"
        "$mainMod ALT, left, resizeactive, -20 0"
      ];

      # Move/resize windows by dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
