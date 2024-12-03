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
  options.programs.lazyvim.extras.editor.telescope = {
    enable = mkEnableOption "the editor.telescope extra";
  };

  config = mkIf cfg.extras.editor.telescope.enable {
    programs.neovim = {
      # set in ./lazyvim/default.nix
      # plugins = [ pkgs.vimPlugins.telescope-nvim ];
    };
  };
}
