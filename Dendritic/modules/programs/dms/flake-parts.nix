{
	flake-file.inputs = 
	{
		dms = 
		{
			url = "github:AvengeMedia/DankMaterialShell/stable";
			inpouts.nixpkgs.follows = "nixpkgs";
		};
		dms-plugin-registry = 
		{
			url = "github:AvengeMedia/dms-plugin-registry";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
}
