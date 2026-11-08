{ ... }:
{
  flake.modules.nixos.kitty = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      kitty
    ];
  };

  flake.modules.homeManager.kitty = { pkgs, ... }: {
    home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 16;

      };
      settings = {
        background_opacity = "0.85";
        background_blur = 3;
        dynamic_background_opacity = true;
        window_padding_width = 12;
        placement_strategy = "center";
        remember_window_size = false;
        initial_window_width = 900;
        initial_window_height = 600;
        sync_to_monitor = true;
        confirm_os_window_close = 0;
        # Transparency / Background Opacity
    # Gruvbox Dark (Hard) Palette
        background = "#1d2021";
        foreground = "#ebdbb2";
        
        cursor = "#ebdbb2";
        cursor_text_color = "#1d2021";
        
        selection_background = "#504945";
        selection_foreground = "#ebdbb2";
        
        color0 = "#1d2021";
        color1 = "#cc241d";
        color2 = "#98971a";
        color3 = "#d79921";
        color4 = "#458588";
        color5 = "#b16286";
        color6 = "#689d6a";
        color7 = "#a89984";
        
        color8 = "#928374";
        color9 = "#fb4934";
        color10 = "#b8bb26";
        color11 = "#fabd2f";
        color12 = "#83a598";
        color13 = "#d3869b";
        color14 = "#8ec07c";
        color15 = "#ebdbb2";
      };

      extraConfig = ''
        # --- Tab Bar Styling (Powerline look) ---
        tab_bar_style powerline
        tab_powerline_style slanted
        tab_bar_edge top
        active_tab_font_style bold
        inactive_tab_font_style normal
    
        # --- Flashy Neon Borders ---
        # Custom glow-like colors matching a magenta/cyan vaporwave vibe
        active_border_color #ff79c6
        inactive_border_color #44475a
        window_border_width 2.0pt
        draw_minimal_borders yes
    
        # --- Mouse & Cursor Settings ---
        cursor_shape beam
        cursor_blink_interval 0.5
        url_style curly
        open_url_with default
        detect_urls yes
    
        # --- Custom Keybindings ---
        map ctrl+shift+t new_tab_with_cwd
        map ctrl+shift+enter new_window_with_cwd
      '';
    };

  };
}
