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
  options.programs.lazyvim.extras.editor.mini-files = {
    enable = mkEnableOption "the editor.mini-files extra";
  };

  config = mkIf cfg.extras.editor.mini-files.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.mini-files ];
    };
  };
}
