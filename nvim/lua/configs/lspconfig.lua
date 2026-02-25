require("nvchad.configs.lspconfig").defaults()

-- read :h vim.lsp.config for changing options of lsp servers

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
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

-- if you dont want to call the enable method in the loop
-- vim.lsp.enable(vim.tbl_keys(servers))
