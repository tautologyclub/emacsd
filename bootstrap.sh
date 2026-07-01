#!/bin/bash
# Bootstrap a fresh Debian/Ubuntu machine with this dotfiles repo.
# Run from the repo root: bash bootstrap.sh
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
HOME_SRC="$REPO/HOME"
ROOT_SRC="$REPO/ROOT"
BIN_SRC="$REPO/bin"

info()  { echo "[+] $*"; }
warn()  { echo "[!] $*"; }
die()   { echo "[✗] $*" >&2; exit 1; }

[[ "$(id -u)" -eq 0 ]] && die "Run as your normal user, not root (sudo will be invoked where needed)"

# ── 1. APT PACKAGES ──────────────────────────────────────────────────────────

info "Installing apt packages..."
sudo apt-get update -qq
sudo apt-get install -y \
    `# window manager` \
    i3 i3blocks dmenu \
    `# terminal & shell` \
    alacritty bash-completion \
    `# emacs` \
    emacs \
    `# X11 tools` \
    xinit xdotool xclip xcape x11-xserver-utils x11-xkb-utils xss-lock unclutter \
    `# compositor` \
    picom \
    `# notifications` \
    dunst libnotify-bin \
    `# screen lock + blur` \
    i3lock maim imagemagick util-linux \
    `# wallpaper` \
    feh \
    `# audio` \
    alsa-utils pulseaudio pavucontrol pasystray \
    `# network / bluetooth / power` \
    network-manager network-manager-gnome blueman xfce4-power-manager \
    `# polkit` \
    policykit-1-gnome \
    `# fonts & theming` \
    fonts-font-awesome \
    `# browser` \
    chromium \
    `# misc utilities` \
    git screen curl wget jq xdg-utils psmisc \
    `# embedded dev` \
    gdb

# ── 2. SYMLINK OVERLAY TREES ─────────────────────────────────────────────────

link_tree() {
    local src="$1"
    local dest_root="$2"
    local use_sudo="${3:-}"

    [[ -d "$src" ]] || return 0

    while IFS= read -r -d '' file; do
        rel="${file#$src/}"
        dest="$dest_root/$rel"
        destdir="$(dirname "$dest")"

        if [[ -n "$use_sudo" ]]; then
            sudo mkdir -p "$destdir"
            if [[ -e "$dest" && ! -L "$dest" ]]; then
                warn "  Skipping $dest (exists and is not a symlink — back it up manually)"
                continue
            fi
            sudo ln -sfn "$file" "$dest"
        else
            mkdir -p "$destdir"
            if [[ -e "$dest" && ! -L "$dest" ]]; then
                warn "  Skipping $dest (exists and is not a symlink — back it up manually)"
                continue
            fi
            ln -sfn "$file" "$dest"
        fi

        info "  $dest"
    done < <(find "$src" -type f -print0)
}

info "Symlinking HOME/ -> ~/ ..."
link_tree "$HOME_SRC" "$HOME"

info "Symlinking ROOT/ -> / ..."
link_tree "$ROOT_SRC" "/" sudo

# ── 3. BIN/ SCRIPTS ───────────────────────────────────────────────────────────
# ~/.emacs.d/bin is expected to be in PATH (set in .bashrc/.bash_profile).
# Scripts are used in place; just ensure they're executable.

info "Ensuring bin/ scripts are executable..."
chmod +x "$BIN_SRC"/*

# ── 4. UDEV ───────────────────────────────────────────────────────────────────

info "Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

# ── 5. SYSTEMD USER SERVICES ─────────────────────────────────────────────────

info "Enabling systemd --user services..."
systemctl --user daemon-reload
systemctl --user enable emacs.service
# nrfgdb and rttlog require SEGGER JLink — enable manually once installed

# ── 6. MANUAL STEPS ───────────────────────────────────────────────────────────

cat <<'EOF'

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MANUAL STEPS REQUIRED:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. SEGGER JLink (for nrfgdb + rttlog services):
   Download from https://www.segger.com/downloads/jlink/
   Install to /opt/SEGGER/JLink/, then:
     systemctl --user enable nrfgdb.service rttlog.service

2. Alacritty — if not in apt (older Debian):
   cargo install alacritty  OR  add the ppa

3. picom — if your i3 config still references 'compton':
   The package is now 'picom'; update the i3 config exec line if needed.

4. Add ~/.emacs.d/bin to PATH if not already in .bashrc:
   export PATH="$HOME/.emacs.d/bin:$PATH"

5. Log out and back in (or reboot) for udev rules and systemd changes to take effect.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
