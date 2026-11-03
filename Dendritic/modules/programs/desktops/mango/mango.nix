{ inputs, ... }:
# flake-parts module. NOTE: `pkgs`/`lib` are NOT available here (only in the
# inner NixOS / Home-Manager modules), so they are not taken as arguments.
#
# Targets MangoWM >= 0.18 (all config keys are snake_case; old names such as
# `borderpx`, `default_mfact`, `exec-once` are rejected). Run:
#   nix flake update mango
{
  # ───────────────────────── NixOS side (LightDM) ─────────────────────────
  flake.modules.nixos.mango = { pkgs, lib, ... }: {
    imports = [ inputs.mango.nixosModules.mango ];

    # Installs mango, registers the "mango" Wayland session for the display
    # manager, and sets up xdg-desktop-portal (wlr + gtk), polkit and xwayland.
    programs.mango.enable = true;

   

    services.displayManager.defaultSession = "mango";
  };

  # ───────────────────────── Home-Manager side ─────────────────────────
  flake.modules.homeManager.mango = { pkgs, lib, ... }: {
    imports = [ inputs.mango.hmModules.mango ];

    # Makes the cursor theme referenced below actually exist.
    home.pointerCursor = lib.mkDefault {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
      gtk.enable = true;
    };

    wayland.windowManager.mango = {
      enable = true;

      settings = {
        # ── Effects ──
        blur = 0;
        blur_layer = 1;
        blur_optimized = 1;
        blur_params_num_passes = 2;
        blur_params_radius = 5;
        blur_params_noise = 0.02;
        blur_params_brightness = 0.9;
        blur_params_contrast = 0.9;
        blur_params_saturation = 1.2;

        shadows = 1;
        layer_shadows = 1;
        shadow_only_floating = 1;
        shadows_size = 12;
        shadows_blur = 15;
        shadows_position_x = 0;
        shadows_position_y = 0;
        shadows_color = "0x000000ff";

        border_radius = 6;
        no_radius_when_single = 0;
        focused_opacity = 1.0;
        unfocused_opacity = 0.85;

        # ── Animation ──
        animations = 1;
        layer_animations = 1;
        animation_type_open = "slide";
        animation_type_close = "slide";
        animation_fade_in = 1;
        animation_fade_out = 1;
        tag_animation_direction = 1;
        zoom_initial_ratio = 0.4;
        zoom_end_ratio = 0.7;
        fade_in_begin_opacity = 0.8;
        fade_out_begin_opacity = 0.8;
        animation_duration_move = 500;
        animation_duration_open = 400;
        animation_duration_tag = 350;
        animation_duration_close = 800;
        animation_duration_focus = 400;
        animation_curve_open = "0.46,1.0,0.29,1.1";
        animation_curve_move = "0.46,1.0,0.29,1";
        animation_curve_tag = "0.46,1.0,0.29,1";
        animation_curve_close = "0.08,0.92,0,1";
        animation_curve_focus = "0.46,1.0,0.29,1";
        animation_curve_opacity_fade_out = "0.58,0.98,0.58,0.98";
        animation_curve_opacity_fade_in = "0.46,1.0,0.29,1";

        # ── Scroller layout ──
        scroller_structs = 20;
        scroller_default_proportion = 0.8;
        scroller_focus_center = 0;
        scroller_prefer_center = 1;
        edge_scroller_pointer_focus = 1;
        scroller_ignore_proportion_single = 1;
        scroller_default_proportion_single = 1.0;
        scroller_proportion_preset = "0.5,0.8,1.0";

        # ── Master-stack layout ──
        new_is_master = 1;
        smart_gaps = 0;
        default_master_factor = 0.55;
        default_master_count = 1;

        # ── Dwindle layout ──
        dwindle_smart_split = 0;
        dwindle_drop_simple_split = 1;
        dwindle_manual_split = 0;
        dwindle_horizontal_split = 1;
        dwindle_vertical_split = 1;
        dwindle_preserve_split = 1;

        # ── Overview ──
        hotarea_size = 10;
        enable_hotarea = 1;
        overview_gap_inner = 5;
        overview_gap_outer = 30;

        # ── Misc ──
        xwayland_persistence = 1;
        sync_obj_enable = 1;
        no_border_when_single = 0;
        axis_bind_apply_timeout = 100;
        focus_on_activate = 1;
        sloppy_focus = 1;
        warp_cursor = 1;
        focus_cross_monitor = 0;
        focus_cross_tag = 0;
        circle_layout = "tile,scroller";
        enable_floating_snap = 1;
        snap_distance = 50;
        cursor_size = 24;
        cursor_theme = "Bibata-Modern-Ice";
        cursor_hide_timeout = 0;
        drag_tile_to_tile = 1;
        single_scratchpad = 1;
        auto_reload_config = 1;

        # ── Keyboard ──
        repeat_rate = 25;
        repeat_delay = 600;
        numlock_on = 1;
        xkb_rules_layout = "us,ru";

        # ── Trackpad / mouse ──
        disable_trackpad = 0;
        tap_to_click = 1;
        tap_and_drag = 1;
        drag_lock = 1;
        mouse_natural_scrolling = 0;
        trackpad_natural_scrolling = 0;
        trackpad_disable_while_typing = 1;
        trackpad_left_handed = 0;
        trackpad_middle_button_emulation = 0;
        swipe_min_threshold = 1;
        mouse_accel_profile = 2;
        mouse_accel_speed = 0.0;

        # ── Appearance ──
        gap_inner_horizontal = 5;
        gap_inner_vertical = 5;
        gap_outer_horizontal = 15;
        gap_outer_vertical = 15;
        scratchpad_width_ratio = 0.8;
        scratchpad_height_ratio = 0.9;
        border_px = 4;
        root_color = "0x201b14ff";
        border_color = "0x444444ff";
        focus_color = "0x8BAA9Bff";
        drop_color = "0x8FBA7C55";
        split_color = "0xEB441EFF";
        maximized_screen_color = "0xBABD2Cff";
        urgent_color = "0xad401fff";
        scratchpad_color = "0xc4939dff";
        global_color = "0x8d64cfff";
        overlay_color = "0x95C381ff";

        # ── Keybindings ──
        # `spawn` runs a program directly; `spawn_shell` is needed for `~`,
        # pipes and $(...).
        bind = [
          "SUPER,Space,spawn,rofi -show drun"
          "SUPER,Q,killclient"
          "SUPER+SHIFT,E,quit"
          "SUPER,F,togglefullscreen"
          "SUPER+SHIFT,R,reload_config"
          "SUPER,W,spawn_shell,~/.local/bin/rofi-wallpaper.sh"
          "SUPER+SHIFT,S,spawn,loginctl suspend"
          "ALT,Return,spawn_shell,xfce4-terminal"
          "ALT,space,spawn_shell,rofi -config ~/.config/mango/rofi/config.rasi -show drun"
          "SUPER,m,quit"
          "ALT,q,killclient"
          "SUPER,Tab,overcircle,next"
          "ALT,Tab,togglejump"
          "SUPER+SHIFT,n,focusstack,next"
          "SUPER,u,focuslast"
          "ALT,Left,focusdir,left"
          "ALT,Right,focusdir,right"
          "ALT,Up,focusdir,up"
          "ALT,Down,focusdir,down"
          "SUPER+SHIFT,Up,exchange_client,up"
          "SUPER+SHIFT,Down,exchange_client,down"
          "SUPER+SHIFT,Left,exchange_client,left"
          "SUPER+SHIFT,Right,exchange_client,right"
          "CTRL+SHIFT,Up,movewin,+0,-50"
          "CTRL+SHIFT,Down,movewin,+0,+50"
          "CTRL+SHIFT,Left,movewin,-50,+0"
          "CTRL+SHIFT,Right,movewin,+50,+0"
          "CTRL+ALT,Up,resizewin,+0,-50"
          "CTRL+ALT,Down,resizewin,+0,+50"
          "CTRL+ALT,Left,resizewin,-50,+0"
          "CTRL+ALT,Right,resizewin,+50,+0"
          "SUPER,g,toggleglobal"
          "ALT,backslash,togglefloating"
          "ALT,a,togglemaximizescreen"
          "ALT,f,togglefullscreen"
          "ALT+SHIFT,f,togglefakefullscreen"
          "SUPER,i,minimized"
          "SUPER,o,toggleoverlay"
          "SUPER+SHIFT,I,restore_minimized"
          "ALT,z,toggle_scratchpad"
          "ALT,e,set_proportion,1.0"
          "ALT,x,switch_proportion_preset"
          "ALT+SUPER+CTRL,Left,scroller_stack,left"
          "ALT+SUPER+CTRL,Right,scroller_stack,right"
          "ALT+SUPER+CTRL,Up,scroller_stack,up"
          "ALT+SUPER+CTRL,Down,scroller_stack,down"
          "ALT+SHIFT,Return,dwindle_toggle_split_direction"
          "SUPER,e,incnmaster,1"
          "SUPER,t,incnmaster,-1"
          "ALT,s,zoom"
          "CTRL+SUPER,i,setlayout,tile"
          "CTRL+SUPER,l,setlayout,scroller"
          "SUPER,n,switch_layout"
          "SUPER,Left,viewtoleft,0"
          "CTRL,Left,viewtoleft_have_client,0"
          "SUPER,Right,viewtoright,0"
          "CTRL,Right,viewtoright_have_client,0"
          "CTRL+SUPER,Left,tagtoleft,0"
          "CTRL+SUPER,Right,tagtoright,0"
          "CTRL,1,view,1,0"
          "CTRL,2,view,2,0"
          "CTRL,3,view,3,0"
          "CTRL,4,view,4,0"
          "CTRL,5,view,5,0"
          "CTRL,6,view,6,0"
          "CTRL,7,view,7,0"
          "CTRL,8,view,8,0"
          "CTRL,9,view,9,0"
          "ALT,1,tag,1,0"
          "ALT,2,tag,2,0"
          "ALT,3,tag,3,0"
          "ALT,4,tag,4,0"
          "ALT,5,tag,5,0"
          "ALT,6,tag,6,0"
          "ALT,7,tag,7,0"
          "ALT,8,tag,8,0"
          "ALT,9,tag,9,0"
          "CTRL+SUPER,1,toggletag,1"
          "CTRL+SUPER,2,toggletag,2"
          "CTRL+SUPER,3,toggletag,3"
          "CTRL+SUPER,4,toggletag,4"
          "CTRL+SUPER,5,toggletag,5"
          "CTRL+SUPER,6,toggletag,6"
          "CTRL+SUPER,7,toggletag,7"
          "CTRL+SUPER,8,toggletag,8"
          "CTRL+SUPER,9,toggletag,9"
          "SUPER,1,toggleview,1"
          "SUPER,2,toggleview,2"
          "SUPER,3,toggleview,3"
          "SUPER,4,toggleview,4"
          "SUPER,5,toggleview,5"
          "SUPER,6,toggleview,6"
          "SUPER,7,toggleview,7"
          "SUPER,8,toggleview,8"
          "SUPER,9,toggleview,9"
          "ALT+SHIFT,Left,focusmon,left"
          "ALT+SHIFT,Right,focusmon,right"
          "ALT+SHIFT,Up,focusmon,up"
          "ALT+SHIFT,Down,focusmon,down"
          "SUPER+ALT,Left,tagmon,left"
          "SUPER+ALT,Right,tagmon,right"
          "SUPER+ALT,Up,tagmon,up"
          "SUPER+ALT,Down,tagmon,down"
          "ALT+SHIFT,X,incgaps,1"
          "ALT+SHIFT,Z,incgaps,-1"
          "ALT+SHIFT,R,togglegaps"
          "NONE,XF86AudioRaiseVolume,spawn_shell,~/.config/mango/scripts/volume.sh up"
          "NONE,XF86AudioLowerVolume,spawn_shell,~/.config/mango/scripts/volume.sh down"
          "NONE,XF86AudioMute,spawn_shell,~/.config/mango/scripts/volume.sh mute"
          "NONE,XF86MonBrightnessUp,spawn_shell,~/.config/mango/scripts/brightness.sh up"
          "NONE,XF86MonBrightnessDown,spawn_shell,~/.config/mango/scripts/brightness.sh down"
          "SUPER,Return,spawn,google-chrome-stable"
          "CTRL+SUPER,Return,spawn,foot -e yazi"
          "CTRL+ALT,a,spawn_shell,grim -g \"$(slurp -b '#2E2A1E55' -c '#fb751bff')\" -t ppm - | satty -f -"
          "SUPER,h,spawn_shell,bash ~/.config/mango/scripts/hide_mangobar.sh"
          "SUPER,l,spawn,swaylock -f -c 000000"
          "CTRL+ALT,backslash,spawn,swaync-client -t"
          "CTRL+ALT,BackSpace,spawn,swaync-client -C"
          "SUPER,p,spawn_shell,bash ~/.config/mango/scripts/monitor.sh"
          "SUPER+SHIFT,p,spawn_shell,bash ~/.config/mango/scripts/virmon.sh"
        ];

        layer_rule = [
          "animation_type_open:zoom,animation_type_close:zoom,layer_name:rofi"
        ];

        mousebind = [
          "SUPER,btn_left,moveresize,curmove"
          "ALT,btn_middle,set_proportion,0.5"
          "SUPER,btn_right,moveresize,curresize"
          "SUPER+CTRL,btn_left,minimized"
          "SUPER+CTRL,btn_right,killclient"
          "SUPER+CTRL,btn_middle,togglefullscreen"
          "NONE,btn_middle,togglemaximizescreen,0"
        ];

        axisbind = [
          "SUPER,UP,viewtoleft_have_client"
          "SUPER,DOWN,viewtoright_have_client"
          "ALT,UP,focusdir,left"
          "ALT,DOWN,focusdir,right"
          "SHIFT+SUPER,UP,exchange_client,left"
          "SHIFT+SUPER,DOWN,exchange_client,right"
        ];

        gesturebind = [
          "none,left,3,focusdir,left"
          "none,right,3,focusdir,right"
          "none,up,3,focusdir,up"
          "none,down,3,focusdir,down"
          "none,right,4,viewtoleft_have_client"
          "none,left,4,viewtoright_have_client"
          "none,up,4,toggleoverview"
          "none,down,4,toggleoverview"
        ];

        tag_rule = [
          "id:1,layout_name:tile"
          "id:2,layout_name:tile"
          "id:3,layout_name:tile"
          "id:4,layout_name:tile"
          "id:5,layout_name:tile"
          "id:6,layout_name:tile"
          "id:7,layout_name:tile"
          "id:8,layout_name:tile"
          "id:9,layout_name:tile"
        ];

        env = [
          "GTK_IM_MODULE,fcitx"
          "QT_IM_MODULE,fcitx"
          "SDL_IM_MODULE,fcitx"
          "XMODIFIERS,@im=fcitx"
          "GLFW_IM_MODULE,ibus"
          "QT_QPA_PLATFORMTHEME,qt5ct"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "QT_WAYLAND_FORCE_DPI,140"
          "QT_QPA_PLATFORM,Wayland;xcb"
        ];
      };

      # Plain shell script run once at session start (no shebang, no `exec-once=`).
      # PipeWire/WirePlumber come from services.pipewire; portals from programs.mango.
      autostart_sh = ''
        waybar &
        noctalia &
        awww-daemon &

        # Set the wallpaper once awww-daemon is up (waits up to ~10s).
        (
          for _ in $(seq 1 50); do
            awww query >/dev/null 2>&1 && break
            sleep 0.2
          done
          awww img "$HOME/Pictures/wallpapers/wp13125984-rust-lang-wallpapers.jpg"
        ) &
      '';
    };
  };
}
