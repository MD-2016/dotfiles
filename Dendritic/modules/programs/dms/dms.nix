(inputs, ... ): 
{
	flake.modules.nixos.dms = {pkgs, ...}: 
	{
		imports = 
		[
			inputs.dms.nixosModules.dank-material-shell
		];

		programs.dank-material-shell = 
		{
			enable = true;
			enableSystemMonitoring = true;
		};
	};
}
