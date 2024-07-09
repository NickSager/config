return {
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        -- "python-lsp-server",
        -- "shellcheck",
        -- "flake8",
        -- "black",
        -- "prettier"
        -- "markdown"
        -- "markdown_inline",
      },
    },
  },

  {
    "mbbill/undotree",
    lazy = false, -- needs to be explicitly set, because of the keys property
    keys = {
      {
        "<leader>U",
        vim.cmd.UndotreeToggle,
        desc = "Toggle undotree",
      },
    },
  },

  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      -- Your options go here
      dap_enabled = true,
      -- name = { "venv", ".venv", "env", ".env" },
      -- poetry_path= "~/.cache/pypoetry/virtualenvs/"
      -- auto_refresh = false
    },
  },

  -- {
  --   "linux-cultist/venv-selector.nvim",
  --   branch = "regexp", -- Use this branch for the new version
  --   cmd = "VenvSelect",
  --   enabled = function()
  --     return LazyVim.has("telescope.nvim")
  --   end,
  --   opts = {
  --     settings = {
  --       options = {
  --         notify_user_on_venv_activation = true,
  --       },
  --     },
  --   },
  --   --  Call config for python files and load the cached venv automatically
  --   ft = "python",
  --   keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  -- },

  -- TODO: setup neotest (https://github.com/nvim-neotest/neotest)
  -- Included in lazyextras
  -- {
  -- "nvim-neotest/neotest",
  -- dependencies = {
  --   "nvim-lua/plenary.nvim",
  --   "antoinemadec/FixCursorHold.nvim",
  --   "nvim-treesitter/nvim-treesitter"
  --   }
  -- },
  --
  --
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = { enabled = true },
        -- pylsp = {},
        pylsp = {
          enabled = false,
          settings = {
            pylsp = {
              plugins = {
                -- formatter options
                black = { enabled = true },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                -- linter options
                pylint = { enabled = true, executable = "pylint" },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                -- type checker
                pylsp_mypy = { enabled = true },
                -- auto-completion options
                jedi_completion = { fuzzy = true },
                -- import sorting
                pyls_isort = { enabled = true },
              },
            },
          },
        },
      },
    },
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
