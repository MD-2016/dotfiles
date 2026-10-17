function fish_prompt

    if set -q KITTY_WINDOW_ID
        echo -n -s $magenta "🧙 [K$KITTY_WINDOW_ID] " $cyan (prompt_pwd) " "
    else
        echo -n -s $magenta "🧙 " $cyan (prompt_pwd) " "
    end
    
    # Save the status of the last executed command
    set -l last_status $status

    # Configure bright, flashy gradient colors (ANSI codes or hex names)
    set -l magenta (set_color ff00ff)
    set -l cyan (set_color 00ffff)
    set -l yellow (set_color ffff00)
    set -l red (set_color ff3333)
    set -l green (set_color 33ff33)
    set -l normal (set_color normal)

    # 1. Wizard Anchor & Context 
    echo -n -s $magenta "🧙 " $cyan (prompt_pwd) " "

    # 2. Flashy Git Integration (Only shows if inside a repository)
    if set -l git_branch (fish_git_prompt)
        echo -n -s $yellow $git_branch " "
    end

    # 3. Status Check Execution Arrow
    if test $last_status -eq 0
        echo -n -s $green "⚡ "
    else
        echo -n -s $red "💥 "
    end

    # Terminate line & reset colors for typing area
    echo -n -s $normal "» "
end
