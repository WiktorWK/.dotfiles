require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- these allow for moving selection up or down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- up and down movements and moving to search results
-- stay in the middle of screen
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local function smart_gd()
  local ok, i18n = pcall(require, "i18n")

  if ok then
    local success = pcall(i18n.goto_translation)
    if success then
      return
    end
  end

  vim.lsp.buf.definition()
end

map("n", "gd", smart_gd, {
  desc = "LSP definition or i18n translation",
})
