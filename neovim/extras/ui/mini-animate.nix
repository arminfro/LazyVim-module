self:
{
  config,
  inputs,
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
  options.programs.lazyvim.extras.ui.mini-animate = {
    enable = mkEnableOption "the ui.mini-animate extra";
  };

  config = mkIf cfg.extras.ui.mini-animate.enable {
    programs.neovim = {
      plugins = [
        (pkgs.vimUtils.buildVimPlugin {
          pname = "mini.animate";
          version = "2024-06-23";
          src = inputs.mini-animate;
        })
      ];
    };
  };
}
