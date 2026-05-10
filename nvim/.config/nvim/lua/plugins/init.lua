return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "scss",
        "tsx",
        "typescript",
        "typescriptreact",
        "vue",
        "java",
        "javascript",
        "json",
        "jsonc",
        "yaml",
      },
      highlight = {
        enable = true,
      },
    },
  },
  -- {
  --   "olimorris/codecompanion.nvim",
  --   lazy = false,
  --   dependencies = {
  --     { "nvim-lua/plenary.nvim" },
  --     {
  --       "nvim-treesitter/nvim-treesitter",
  --       lazy = false,
  --       build = ":TSUpdate",
  --     },
  --   },
  --   opts = {
  --     --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
  --     strategies = {
  --       chat = { adapter = "gemini" },
  --     },
  --     adapters = {
  --       gemini = function()
  --         return require("codecompanion.adapters").extend("gemini", {
  --           env = {
  --             api_key = "cmd:echo $GEMINI_API_KEY",
  --           },
  --         })
  --       end,
  --     },
  --     opts = {
  --       log_level = "DEBUG",
  --     },
  --   },
  -- },
  {
    "yelog/i18n.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    ft = { "javascript", "typescript", "vue", "typescriptreact", "json" },
    config = function()
      local files = vim.fn.glob("**/src/i18n", true, true)
      local sources = {}
      for _, file in ipairs(files) do
        if vim.uv.fs_stat(file) then
          table.insert(sources, { pattern = "./" .. file .. "/{locales}/index.ts" })
        end
      end
      require("i18n").setup {
        locales = { "en-US", "de" },
        sources = sources,
      }
    end,
  },
}
