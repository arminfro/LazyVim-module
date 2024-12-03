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
  options.programs.lazyvim.extras.editor.mini-diff = {
    enable = mkEnableOption "the editor.mini-diff extra";
  };

  config = mkIf cfg.extras.editor.mini-diff.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.mini-diff ];
    };
  };
}
