{
  description = "MD's nix config";

  inputs = {
    # change to github:nixos/nixpkgs/nixos-23.05 for unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager = {
      # change to github:nix-community/home-manager for unstable
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations = let
      user = "md89";
      commonModules = [
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user} = {
              imports = [./home.nix];

              home = {
                username = user;
                homeDirectory = "/home/${user}";
                # do not change this value
                stateVersion = "23.05";
              };

              # Let Home Manager install and manage itself.
              programs.home-manager.enable = true;
            };
          };
        }
        ./configuration.nix
      ];
    in {
      # update with `nix flake update`
      # rebuild with `nixos-rebuild switch --flake .#dev`
      dev = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs system user;
        };

        modules =
          commonModules
          ++ [
            # host specific configuration
            ./hosts/dev/configuration.nix
            # host specific hardware configuration
            ./hosts/dev/hardware-configuration.nix
          ];
      };
    };

    templates = let
      welcomeText = ''
        # `.devenv` and `direnv` should be added to `.gitignore`
        ```sh
          echo .devenv >> .gitignore
          echo .direnv >> .gitignore
        ```
      '';
    in {
      # initialize with `nix flake init --template github.com:MD-2016/dotfiles#golang`
      golang = {
        inherit welcomeText;
        path = ./templates/golang;
        description = "devenv for golang";
      };

      # initialize with `nix flake init --template github.com:MD-2016/dotfiles#rust`
      rust = {
        inherit welcomeText;
        path = ./templates/rust;
        description = "devenv for rust";
      };
    };
  };
}
