{ config, pkgs, ... }: {
	home.username = "md";
	home.homeDirectory = "/home/md";
	home.stateVersion = "26.05";

	home.packages = [ pkgs.htop pkgs.nerd-fonts.jetbrains-mono ];

	fonts.fontconfig.enable = true;

	programs.home-manager.enable = true;

	programs.kitty = {
		enable = true;
		font = {
			name = "JetBrainsMono Nerd Font";
			size = 16;
					
		};
		settings = {
			background_opacity = "0.85";
			background_blur = 32;
			dynamic_background_opacity = true;
			window_padding_width = 12;
			placement_strategy = "center";
			remember_window_size = false;
			initial_window_width = 900;
			initial_window_height = 600;
			sync_to_monitor = true;
			confirm_os_window_close = 0;
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

	
	  home.file = {
	    ".config/fastfetch/config.jsonc" = {
	     source = ./config.jsonc;
	    };
	  };

	  home.file.".config/mango/" = {
	  	source = ./mango;
	  	recursive = true;
	  };

	  programs.rofi = {
	  	enable = true;
	  	package = pkgs.rofi;
	  	theme = "~/.config/rofi/flashy.rasi";
	  };
}
