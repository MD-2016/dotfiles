{ inputs, ... }:
let
  username = "md";
in
{
  flake.modules.homeManager."${username}" =
    { ... }:
    {
      imports = with inputs.self.modules.homeManager; [
      ];
      home.username = "${username}";
    };
}
