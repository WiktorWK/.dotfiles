local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    scss = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    go = { "goimports", "gofmt" },
    sql = { "sqlfluff" },
    -- Use the "*" filetype to run formatters on all filetypes.
    ["*"] = { "codespell" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
    java = { "google-java-format" },
  },

  formatters = {
    sqlfluff = {
      command = "sqlfluff",
      args = {
        "format",
        "--dialect",
        "postgres",
        "-",
      },
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = true,
  },

  ft_parsers = {
    javascript = "babel",
    javascriptreact = "babel",
    typescript = "typescript",
    typescriptreact = "typescript",
    vue = "vue",
    css = "css",
    scss = "scss",
    less = "less",
    html = "html",
    json = "json",
    jsonc = "json",
    yaml = "yaml",
    markdown = "markdown",
    ["markdown.mdx"] = "mdx",
    graphql = "graphql",
    handlebars = "glimmer",
    sql = "sql",
  },
}

return options
