{...}: 
{
	flake.modules.nixos.shell = {pkgs, ...}: {
		environment.systemPackages = with pkgs; 
		[
			zsh-autosuggestions
			zsh-powerlevel10k
		];
		
		programs.zsh = 
		{
			enable = true;
			enableCompletion = true;
			autosuggestions.enable = true;
			syntaxHighlighting.enable = true;

			promptInit = "
				source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
				source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
			";

			shellAliases = {
			  # Custom workflow updates for configuration.nix
			  micbash = "sudo micro /etc/nixos/configuration.nix";
			  srcb = "sudo nixos-rebuild switch";

			  # General aliases
			  "~" = "cd ~";
			  c = "cd";
			  ".." = "cd ..";
			  mkd = "mkdir -p";
			  clr = "clear";
			  hcw = "history -c && history -w";
			  dmg = "sudo dmesg";
			  logout = "gnome-session-quit";
			  suspend = "systemctl suspend";
			  ffx = "(firefox &> /dev/null &)";
			  ff = "fastfetch -c /etc/nixos/config.jsonc";
			  vnst = "sudo virsh net-start default";

			  # Flatpak specific
			  bottles = "(flatpak run com.usebottles.bottles &> /dev/null &)";
			  wolf = "(flatpak run io.gitlab.librewolf-community &> /dev/null &)";
			  discord = "(discord  &>  /dev/null &)";
			  hexchat = "(flatpak run io.github.Hexchat &> /dev/null  &)";
			  element = "(flatpak run im.riot.Riot &> /dev/null &)";
			  shortwave = "(flatpak run de.haeckerfelix.Shortwave &> /dev/null &)";
			  seal = "(flatpak run com.github.tchx84.Flatseal &> /dev/null &)";
			  imgview = "(flatpak run org.gnome.Loupe &> /dev/null &)";
			  pdesk = "(flatpak run io.podman_desktop.PodmanDesktop &> /dev/null &)";
			  boxbuddy = "(flatpak run io.github.dvlv.boxbuddyrs &> /dev/null &)";
			  lunacy = "(flatpak run com.icons8.Lunacy &> /dev/null &)";
			  obsidian = "(flatpak run md.obsidian.Obsidian &> /dev/null &)";
			  flatup = "flatpak update";

			  top = "htop";
			  notes = "micro";

			  # Slackware Commands
			  slackup = "sudo slackpkg update";
			  slackrm = "sudo slackpkg remove";
			  slackin = "sudo slackpkg install";
			  slackupga = "sudo slackpkg upgrade-all";
			  slackpkgupg = "sudo slackpkg upgrade";
			  slackpkginn = "sudo slackpkg install-new";
			  slackpkggpg = "sudo slackpkg update gpg";

			  # Sway
			  vsw = "vim .config/sway/config";

			  # Distrobox specific
			  distent = "distrobox enter";
			  pacup = "sudo pacman -Syu";
			  y = "yay";

			  # Nixos
			  micronixc = "sudo micro /etc/nixos/configuration.nix";
			  micronixf = "sudo micro /etc/nixos/flake.nix";
			  micronixh = "sudo micro /etc/nixos/home.nix";
			  micros = "sudo micro";
			  nixswitch = "sudo nixos-rebuild switch";
			  nhs = "nh os switch 'path:.' --ask";
			  nhu = "nh os switch 'path:.' --ask --update";

			  # Commented out aliases
			  # shopt -s globstar
			  # podman = "podman";
			  # ll = "ls -l";
			  # la = "ls -A";
			  # l = "ls -CF";
			  # search = "pacman -Ss";
			  # office = "(flatpak run org.libreoffice.LibreOffice &> /dev/null &)";
			  # spotify = "(flatpak run com.spotify.Client &> /dev/null &)";
			  # dquilt = "quilt --quiltrc=\${HOME}/.quiltrc-dpkg";
			};

		};	
	};
}
