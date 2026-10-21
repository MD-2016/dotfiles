{ pkgs }:

pkgs.writeShellApplication {
  name = "spotify-fastfetch-monitor";

  # Nix automatically isolates and provides these exact packages to your script's PATH
  runtimeInputs = [
    pkgs.playerctl
    pkgs.curl
    pkgs.gnused
    pkgs.jq
    pkgs.procps    # Provides 'pkill'
    pkgs.coreutils # Provides 'mkdir', 'mv', 'cp', 'sleep', etc.
  ];

  # Using single quotes ('' '') for a multi-line Nix string.
  # Note: All literal Bash variables like ${1} or ${URL} must be escaped as ''${1} or ''${URL} 
  # so Nix doesn't mistake them for Nix variables.
  text = ''
    # User-specific temporary location for album cover image
    COVER_DIR="''${HOME}/.spotify_covers"
    mkdir -p "''${COVER_DIR}"
    TMP="/tmp/spotify_cover.jpg"

    # Fastfetch JSON config path
    FASTFETCH_CONFIG="''${HOME}/.config/fastfetch/config.jsonc"

    decode_url() {
        printf '%b' "''${1//%/\\x}"
    }

    download_cover() {
        local URL="''${1}"
        if [[ ''${URL} == file://* ]]; then
            FILE_PATH=$(decode_url "''${URL#file://}")

            if [[ -f "''${FILE_PATH}" ]]; then
                cp "''${FILE_PATH}" "''${TMP}"
            else
                echo "File not found: ''${FILE_PATH}"
                return 1
            fi
        else
            curl -sL "''${URL}" -o "''${TMP}" || { echo "Failed to download: ''${URL}"; return 1; }
        fi
    }

    update_cover() {
        URL=$(playerctl metadata mpris:artUrl 2>/dev/null)

        if [ -z "''${URL}" ]; then
            echo "No song is currently playing."
            return 1
        fi

        if ! download_cover "''${URL}"; then
            return 1
        fi

        if [[ ! -f "''${TMP}" ]]; then
            echo "Cover image not downloaded correctly."
            return 1
        fi

        SONG_NAME=$(playerctl metadata title)
        ARTIST_NAME=$(playerctl metadata artist)
        FILE_NAME=$(echo "''${SONG_NAME} - ''${ARTIST_NAME}.jpg" | sed 's/[^a-zA-Z0-9]/_/g')

        TARGET_PATH="''${COVER_DIR}/''${FILE_NAME}"
        mv "''${TMP}" "''${TARGET_PATH}"

        if [[ -f "''${FASTFETCH_CONFIG}" ]]; then
            jq --arg imagePath "''${TARGET_PATH}" \
               '.logo.source = $imagePath' \
               "''${FASTFETCH_CONFIG}" > "''${FASTFETCH_CONFIG}.tmp" && mv "''${FASTFETCH_CONFIG}.tmp" "''${FASTFETCH_CONFIG}"
            
            pkill -USR1 fastfetch
            echo "Updated Fastfetch with new cover image: ''${TARGET_PATH}"
        else
            echo "Fastfetch config not found at ''${FASTFETCH_CONFIG}, skipped JSON update."
        fi
        
        return 0
    }

    while true; do
        update_cover
        sleep 5
    done
  '';
}
