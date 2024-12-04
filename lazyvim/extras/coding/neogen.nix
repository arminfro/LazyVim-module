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
  options.programs.lazyvim.extras.coding.neogen = {
    enable = mkEnableOption "the coding.neogen extra";
  };

  config = mkIf cfg.extras.coding.neogen.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.neogen ];
    };
  };
}
