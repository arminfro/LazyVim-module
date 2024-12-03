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
  options.programs.lazyvim.extras.lang.git = {
    enable = mkEnableOption "the lang.git extra";
  };

  config = mkIf cfg.extras.lang.git.enable {
    programs.neovim = {
      plugins = [
        pkgs.vimPlugins.cmp-git
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (
          plugins: with plugins; [
            git_config
            gitcommit
            git_rebase
            gitignore
            gitattributes
          ]
        ))
      ];
    };
  };
}
