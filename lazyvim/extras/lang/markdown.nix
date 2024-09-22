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
  options.programs.lazyvim.extras.lang.markdown = {
    enable = mkEnableOption "the lang.markdown extra";
  };

  config = mkIf cfg.extras.lang.markdown.enable {
    programs.neovim = {
      extraPackages = builtins.attrValues { inherit (pkgs) markdown-toc markdownlint-cli2 marksman; };

      plugins = [
        pkgs.vimPlugins.markdown-preview-nvim
        (pkgs.vimUtils.buildVimPlugin {
          pname = "markdown.nvim";
          version = "2024-08-09";
          src = inputs.markdown-nvim;
        })
      ];
    };
  };
}