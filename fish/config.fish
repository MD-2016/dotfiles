# ~/.config/fish/config.fish
# Configured for Fish Shell on Slackware/Debian

# Only run in interactive sessions
if status is-interactive

    # =========================================================================
    # Environment & Path Modifications
    # =========================================================================
    # Fish uses fish_add_path to safely append to PATH without duplicates
    set -gx EDITOR vim
    set -gx VISUAL vim
    set -gx CARGO /home/md/.cargo/bin

    # ==========================================================================
    # Fancy Color Scheme
    # ==========================================================================
    # 🧙 Wizard Theme Syntax Highlighting
	set -g fish_color_command 00ffff --bold      # Cyan commands
	set -g fish_color_param ff00ff               # Magenta parameters
	set -g fish_color_autosuggestion 555555      # Dark gray auto-complete
	set -g fish_color_error ff3333 --bold        # Bright red errors
	set -g fish_color_quote ffff00               # Yellow quotes
	set -g fish_color_redirection 33ff33         # Green redirect piping

    
    fish_add_path $CARGO
    fish_add_path /usr/local/sbin
    fish_add_path ~/awww/target/release/

    # Quickshell /usr/local
    set -gx QML_IMPORT_PATH "/usr/local/lib64/qt6/qml:$QML_IMPORT_PATH"

    # =========================================================================
    # Prompt Customization
    # =========================================================================
    # Replicates your '[\u@\h \W]\$ ' Bash prompt style natively
    function fish_prompt
        echo -n "["(prompt_login)" "(basename (prompt_pwd))"]\$ "
    end

    # =========================================================================
    # General Aliases
    # =========================================================================
    alias ls="ls --color=auto"
    alias grep="grep --color=auto"
    alias micbash="micro ~/.config/fish/config.fish" # Updated for Fish
    alias srcb="source ~/.config/fish/config.fish"   # Updated for Fish
    #alias ~="cd ~"
    abbr -a home 'cd ~'
    alias c="cd"
    alias ..="cd .."
    alias mkd="mkdir -p"
    alias clr="clear"
    alias hcw="history clear"                       # Updated to native Fish
    alias dmg="sudo dmesg"
    alias logout="gnome-session-quit"
    alias suspend="systemctl suspend"
    alias ff="fastfetch -c ~/.config/fastfetch/config.jsonc"
    alias top="htop"
    alias notes="micro"
    alias clrcb="xclip -sel clip < /dev/null"
    alias spotm="cd ~/.config/fastfetch/ && ./spotty.sh"
    alias vsw="vim .config/sway/config"

    # Virtual network starter for vm
    alias vnst="sudo virsh net-start default"

    # =========================================================================
    # Background Applications (Fixed for Fish)
    # =========================================================================
    # Fish does not support subshell grouping syntax like (command &).
    # Instead, we send output to /dev/null and disown the job natively.
    alias ffx="firefox >/dev/null 2>&1 &; disown"
    alias bottles="flatpak run com.usebottles.bottles >/dev/null 2>&1 &; disown"
    alias wolf="flatpak run io.gitlab.librewolf-community >/dev/null 2>&1 &; disown"
    alias discord="discord >/dev/null 2>&1 &; disown"
    alias hexchat="flatpak run io.github.Hexchat >/dev/null 2>&1 &; disown"
    alias element="flatpak run im.riot.Riot >/dev/null 2>&1 &; disown"
    alias shortwave="flatpak run de.haeckerfelix.Shortwave >/dev/null 2>&1 &; disown"
    alias seal="flatpak run com.github.tchx84.Flatseal >/dev/null 2>&1 &; disown"
    alias imgview="flatpak run org.gnome.Loupe >/dev/null 2>&1 &; disown"
    alias pdesk="flatpak run io.podman_desktop.PodmanDesktop >/dev/null 2>&1 &; disown"
    alias boxbuddy="flatpak run io.github.dvlv.boxbuddyrs >/dev/null 2>&1 &; disown"
    alias lunacy="flatpak run com.icons8.Lunacy >/dev/null 2>&1 &; disown"
    alias obsidian="flatpak run md.obsidian.Obsidian >/dev/null 2>&1 &; disown"
    alias flatup="flatpak update"

    # =========================================================================
    # Package Managers
    # =========================================================================
    # Debian specific
    alias search="apt search"
    alias add="sudo apt install"
    alias remove="sudo apt remove"
    alias distup="sudo apt dist-upgrade"
    alias update="sudo apt update"
    alias upgrade="sudo apt upgrade"
    alias full="sudo apt full-upgrade"
    alias purge="sudo apt purge"
    alias show="apt show"
    alias aplist="apt list"
    alias autoremoove="sudo apt autoremove"
    alias lsbugs="apt-listbugs"

    # Slackware
    alias slackup="sudo slackpkg update"
    alias slackrm="sudo slackpkg remove"
    alias slackin="sudo slackpkg install"
    alias slackupga="sudo slackpkg upgrade-all"
    alias slackpkgupg="sudo slackpkg upgrade"
    alias slackpkginn="sudo slackpkg install-new"
    alias slackpkggpg="sudo slackpkg update gpg"

    # Distrobox / Arch
    alias distent="distrobox enter"
    alias pacup="sudo pacman -Syu"
    alias y="yay"

    # =========================================================================
    # Custom Functions
    # =========================================================================
    # Fish functions use 'and' chains instead of Bash '&&' syntax.
    
    # Function for Arch updates
    function pacupy
        pacup; and y
    end

    # Function for Apt updates
    function updg
        update; and upgrade
    end

    # Function for fastfetch music
    function musicfetch
        spotm; and ff
    end

end
