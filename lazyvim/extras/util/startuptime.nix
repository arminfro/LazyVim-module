self:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.programs.lazyvim;
in
{
  options.programs.lazyvim.extras.util.startuptime = {
    enable = mkEnableOption "the util.startuptime extra";
  };

  config = mkIf cfg.extras.util.startuptime.enable {
    programs.neovim = {
      extraPackages = [
        pkgs.curl
      ];

      plugins = [
        pkgs.vimPlugins.vim-startuptime
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (
          plugins: with plugins; [
            http
            graphql
          ]
        ))
      ];
    };
  };
}
