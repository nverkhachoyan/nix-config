{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
      };
    };
    nvim-tree.enable = true;
    nvim-autopairs.enable = true;
    illuminate.enable = true;
    trouble.enable = true;
    nvim-surround.enable = true;
    luasnip.enable = true;
    lualine.enable = true;

    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<C-space>";
            node_incremental = "<C-space>";
            scope_incremental = "<C-s>";
            node_decremental = "<bs>";
          };
        };
      };
      nixGrammars = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        lua
        javascript
        typescript
        rust
        go
        python
        nix
        bash
        json
        make
        markdown
        regex
        toml
        vim
        vimdoc
        xml
        yaml
        c
        cpp
      ];
    };

    cmp = {
      enable = true;
      settings = {
        snippet.expand = ''
          function(args)
            require("luasnip").lsp_expand(args.body)
          end
        '';
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
        };
      };
    };

    lsp = {
      enable = true;
      keymaps = {
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Go to definition";
          };
          gr = {
            action = "references";
            desc = "References";
          };
          gi = {
            action = "implementation";
            desc = "Implementation";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>rn" = {
            action = "rename";
            desc = "Rename";
          };
          "<leader>ca" = {
            action = "code_action";
            desc = "Code action";
          };
        };
      };
      servers = {
        lua_ls.enable = true;
        ts_ls.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        gopls.enable = true;
        clangd.enable = true;
        nixd.enable = true;
        pyright.enable = true;
      };
    };

    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          lua = [ "stylua" ];
          python = [ "black" ];
          javascript = [ "prettier" ];
          typescript = [ "prettier" ];
          rust = [ "rustfmt" ];
          go = [ "gofmt" ];
          nix = [ "nixfmt" ];
          c = [ "clang-format" ];
          cpp = [ "clang-format" ];
          "_" = [ "trim_whitespace" ];
        };
        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
      };
    };

    lint = {
      enable = true;
      lintersByFt = {
        markdown = [ "vale" ];
        python = [ "pylint" ];
      };
      autoCmd = {
        event = "BufWritePost";
      };
    };
  };
}
