{inputs,...}: 
{
  flake.modules.nixos.development = {...}:
    {
      imports = [
        inputs.nixvim.nixosModules.nixvim
      ];
      programs.nixvim = {
        enable = true;
      };
    };

    flake.modules.homeManager.development = {...}: 
    {
      imports = [
        inputs.nixvim.homeManagerModules.nixvim
      ];
      programs.nixvim = {
        enable = true;
        colorschemes.tokyonight.enable = true;
        
        plugins = {
          lsp = {
            enable = true;
            servers = {
              clangd.enable = true;
              gopls.enable = true;
              rust_analyzer.enable = true;
              zls.enable = true;
              solargraph.enable = true;
              java_language_server.enable = true;
            };
          };
          treesitter.enable = true;
          telescope.enable = true;
        };
      };
    };
}