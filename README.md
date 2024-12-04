# LazyVim-module

[Flake](https://wiki.nixos.org/wiki/Flakes) with a
[Home Manager](https://nix-community.github.io/home-manager/) module for [LazyVim](https://lazyvim.github.io/).

## 💡 Motivation

One of my biggest apprehensions to installing NixOS was
the trouble it would take to use my favorite setup for Neovim: LazyVim.
For some reason I installed it anyway and struggled through the steep learning curve.
LazyVim-module configures Neovim to work with LazyVim and its extras.
It will leave you free to struggle through the configuration of other programs.

## 🚀 Quick Start

> [!IMPORTANT]
> LazyVim-module requires packages that are not available in nixos-24.05.

Simply import the module and enable lazyvim!

Example `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # add LazyVim-module
    LazyVim = {
      url = "github:matadaniel/LazyVim-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    {
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [ ./home-manager/home.nix ];
      };
    };
}
```

Example `home-manager/home.nix`:

```nix
{ inputs, ... }:
{
  imports = [ inputs.LazyVim.homeManagerModules.default ];

  programs.lazyvim = {
    enable = true;
  };
}
```

## 📖 Usage

Enable extras

```nix
{
  programs.lazyvim = {
    extras = {
      coding = {
        luasnip.enable = true;
        mini-surround.enable = true;
        neogen.enable = true;
        yanky.enable = true;
      };

      editor = {
        aerial.enable = true;
        dial.enable = true;
        inc-rename.enable = true;
        mini-diff.enable = true;
        mini-files.enable = true;
        overseer.enable = true;
        refactoring.enable = true;
        telescope.enable = true;
      };

      formatting = {
        prettier.enable = true;
      };

      lang = {
        astro.enable = true;
        git.enable = true;
        json.enable = true;
        markdown.enable = true;
        nix.enable = true;
        prisma.enable = true;
        svelte.enable = true;
        tailwind.enable = true;
        typescript.enable = true;
      };

      linting = {
        eslint.enable = true;
      };

      test = {
        core.enable = true;
      };

      ui = {
        mini-animate.enable = true;
      };

      util = {
        dot.enable = true;
        mini-hipatterns.enable = true;
      };
    };
  };
}
```

Bring your own plugins

```nix
{ pkgs, ... }:
{
  programs.neovim = {
    plugins = [ pkgs.vimPlugins.undotree ];
  };

  xdg.configFile."nvim/lua/plugins/editor.lua".source = ./editor.lua;
}
```

```lua
-- editor.lua

return {
	{
		"mbbill/undotree",
		keys = { { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" } },
		init = function()
			vim.g.undotree_WindowLayout = 4
		end,
	},
}
```

Use lua modules in `plugins` to support subfolders and finer file structure control

```nix
{ pkgs, ... }:
{
  programs.lazyvim = {
    lazy-plugin-specs = [ "plugins.core" ]
    plugins = [ pkgs.vimPlugins.undotree ];
  };

  xdg.configFile."nvim/lua/plugins/core/editor.lua".source = ./core/editor.lua;
}
```

Enable optional programs

```nix
{
  programs = {
    lazygit.enable = true;

    ripgrep.enable = true;
  };
}
```

## 🤝 Contributing

If there is an extra that you always use that is not currently [supported](lazyvim/extras),
please open an issue if there is not one open already!
