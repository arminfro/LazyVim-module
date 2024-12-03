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
  options.programs.lazyvim.extras.editor.refactoring = {
    enable = mkEnableOption "the editor.refactoring extra";
  };

  config = mkIf cfg.extras.editor.refactoring.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.refactoring-nvim ];
    };
  };
}
