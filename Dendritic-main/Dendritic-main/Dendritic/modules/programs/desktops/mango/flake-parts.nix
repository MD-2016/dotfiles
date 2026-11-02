{ ... }: 
{
  flake-file.inputs = 
    {
      mango = 
        {
          url = "github:mangowm/mango";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    };
}