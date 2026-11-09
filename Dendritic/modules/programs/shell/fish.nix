{ ... }: 
{
	flake.modules.nixos.shell = {pkgs, ... }: 
	{
		programs.fish.enable = true;

		environment.systemPackages = with pkgs; 
		[
			fishPlugins.done
			fishPlugins.fzf-fish
			fishPlugins.forgit
		];
	};
}
