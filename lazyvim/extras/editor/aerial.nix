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
  options.programs.lazyvim.extras.editor.aerial = {
    enable = mkEnableOption "the editor.aerial extra";
  };

  config = mkIf cfg.extras.editor.aerial.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.aerial-nvim ];
    };
  };
}
