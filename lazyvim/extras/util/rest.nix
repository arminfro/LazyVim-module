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
  options.programs.lazyvim.extras.util.rest = {
    enable = mkEnableOption "the util.rest extra";
  };

  config = mkIf cfg.extras.util.rest.enable {
    programs.neovim = {
      extraPackages = [
        pkgs.curl
      ];

      plugins = [
        pkgs.vimPlugins.kulala-nvim
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
