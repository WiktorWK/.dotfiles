require("nvchad.configs.lspconfig").defaults()

-- read :h vim for changing options of lsp servers

local vue_language_server_path = vim.fn.stdpath "data"
  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}

local servers = {
  golangci_lint_ls = {},
  gopls = {},
  html = {},
  css_variables = {},
  cssls = {},
  eslint = {},
  ts_ls = {},
  tailwindcss = {},
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },
  docker_language_server = {},
  jsonls = {},
  prettier = {},
  postgres_lsp = {},
  jdtls = {},
  vue_ls = {},
  vtsls = {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            vue_plugin,
          },
        },
      },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

-- if you dont want to call the enable method in the loop
-- vim.lsp.enable(vim.tbl_keys(servers))
