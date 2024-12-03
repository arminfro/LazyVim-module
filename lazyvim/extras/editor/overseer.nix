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
  options.programs.lazyvim.extras.editor.overseer = {
    enable = mkEnableOption "the editor.overseer extra";
  };

  config = mkIf cfg.extras.editor.overseer.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.overseer-nvim ];
    };
  };
}
