return {
  "lervag/vimtex",
  lazy = false,
  config = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_quickfix_mode = 0
    vim.g.tex_flavor = "latex"
    vim.g.vimtex_syntax_enabled = 1 -- Force le highlighting de vimtex (par défaut)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.textwidth = 80
      end,
    })
  end,
  ft = { "tex" },
}
