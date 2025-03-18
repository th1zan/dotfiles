-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Options pour les mappings
local opts = { noremap = true, silent = true }

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)

-- Raccourci 1 : En mode normal, 3x 'y' copie l'intégralité du document
vim.keymap.set("n", "yyy", ":silent %y<CR>", opts)

-- Raccourci 2 : En mode visuel, 3x 'y' copie la fonction entière où se trouve le curseur
vim.keymap.set("v", "yyy", function()
  -- Afficher un message de débogage (peut être supprimé après test)
  vim.notify("Selecting function", vim.log.levels.INFO)
  -- Sélectionner la fonction entière avec Treesitter
  require("nvim-treesitter.textobjects.select").select_textobject("@function.outer")
  -- Copier la sélection
  vim.cmd("silent normal! y")
end, { noremap = true, silent = true })

-- shortcut for vimtex
vim.keymap.set("n", "<leader>cc", ":VimtexCompile<CR>", { desc = "Compile LaTeX" })
vim.keymap.set("n", "<leader>cv", ":VimtexView<CR>", { desc = "View PDF" })
vim.keymap.set("n", "<leader>ce", ":VimtexErrors<CR>", { desc = "Show Errors" })

-- WhichKey plugin mappings for ChatGPT
local wk = require("which-key")
wk.add({
  { "<leader>a", group = "ChatGPT", icon = "" }, -- Définit le groupe ChatGPT
  { "<leader>ac", "<cmd>ChatGPT<CR>", desc = "ChatGPT", icon = "", mode = { "n", "v" } },
  {
    "<leader>ae",
    "<cmd>ChatGPTEditWithInstruction<CR>",
    desc = "Edit with instruction",
    icon = "",
    mode = { "n", "v" },
  },
  {
    "<leader>ag",
    "<cmd>ChatGPTRun grammar_correction<CR>",
    desc = "Grammar Correction",
    icon = "",
    mode = { "n", "v" },
  },
  { "<leader>at", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", icon = "", mode = { "n", "v" } },
  { "<leader>ak", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", icon = "", mode = { "n", "v" } },
  { "<leader>ad", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", icon = "", mode = { "n", "v" } },
  { "<leader>aa", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", icon = "", mode = { "n", "v" } },
  { "<leader>ao", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", icon = "", mode = { "n", "v" } },
  { "<leader>as", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", icon = "", mode = { "n", "v" } },
  { "<leader>af", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", icon = "", mode = { "n", "v" } },
  { "<leader>ax", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", icon = "", mode = { "n", "v" } },
  { "<leader>ar", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit", icon = "", mode = { "n", "v" } },
  {
    "<leader>al",
    "<cmd>ChatGPTRun code_readability_analysis<CR>",
    desc = "Code Readability Analysis",
    icon = "",
    mode = { "n", "v" },
  },
})
