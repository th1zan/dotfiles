return {
  "hat0uma/doxygen-previewer.nvim",
  opts = {},
  dependencies = { "hat0uma/prelive.nvim" },
  cmd = {
    "DoxygenOpen",
    "DoxygenUpdate",
    "DoxygenStop",
    "DoxygenLog",
    "DoxygenTempDoxyfileOpen",
  },
  config = function()
    require("doxygen-previewer").setup({
      tempdir = vim.fn.stdpath("cache"),
      update_on_save = true,
      doxygen = {
        cmd = "doxygen",
        doxyfile_patterns = {
          "Doxyfile",
          "doc/Doxyfile",
          "docs/Doxyfile",
        },
        fallback_cwd = function()
          return vim.fs.dirname(vim.api.nvim_buf_get_name(0))
        end,
        override_options = {},
      },
    })
  end,
}
