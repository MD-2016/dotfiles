#!/usr/bin/env python3
import os
import re
import subprocess

# Possible config paths on Slackware-current
CONFIG_PATHS = [
    os.path.expanduser("~/.config/mango/mango.conf"),
    os.path.expanduser("~/.config/mango/config"),
    os.path.expanduser("~/.config/mango/config.conf")
]

def find_config():
    for path in CONFIG_PATHS:
        if os.path.exists(path):
            return path
    return CONFIG_PATHS[0] # Default fallback

def parse_config():
    config_path = find_config()
    entries = []
    current_section = "General / Shortcuts"

    if not os.path.exists(config_path):
        return "Error: Config file not found!"

    with open(config_path, "r") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            
            # Capture section headers from comments (e.g., `# reload config` or `# rofi`)
            if line.startswith("#"):
                comment_text = line.lstrip("# ").strip()
                if comment_text and not comment_text.startswith("layerrule") and not comment_text.startswith("bind"):
                    current_section = comment_text.title()
                continue

            # Match bind lines (bind, bindc, mousebind, axisbind, gesturebind)
            match = re.match(r"^(bind[a-z]*|mousebind|axisbind|gesturebind)=([^,]+),([^,]+),(.*)", line)
            if match:
                b_type, mods, key, action = match.groups()
                
                # Format modifiers and keys to look cleaner
                mods = mods.replace("+", " + ").upper()
                key = key.replace("code:", "").upper()
                
                # Clean up action details for readability
                action_clean = action.split(",")[0].replace("_", " ").title()
                
                description = f"[{current_section}] {mods} + {key}"
                detail = f"{action_clean} ({action})" if action else action_clean
                
                entries.append(f"{description:<45} ➔  {detail}")

    return "\n".join(entries)

def main():
    keybinds_text = parse_config()
    
    rofi_command = [
        "rofi",
        "-config", os.path.expanduser("~/.config/mango/rofi/config.rasi"),
        "-dmenu",
        "-i",
        "-p", "MangoWC Keybinds"
    ]
    
    process = subprocess.Popen(rofi_command, stdin=subprocess.PIPE, text=True)
    process.communicate(input=keybinds_text)

if __name__ == "__main__":
    main()