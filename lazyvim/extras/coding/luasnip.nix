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
  options.programs.lazyvim.extras.coding.luasnip = {
    enable = mkEnableOption "the coding.luasnip extra";
  };

  config = mkIf cfg.extras.coding.luasnip.enable {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        cmp_luasnip
        friendly-snippets
        luasnip
        (pkgs.vimUtils.buildVimPlugin {
          pname = "blink.compat";
          version = "v1.0.0";
          src = self.inputs.blink-compat;
        })
      ];
    };
  };
}
