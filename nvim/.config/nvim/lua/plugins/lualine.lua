return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight-storm", -- Assure-toi que le thème correspond
          section_separators = { "", "" },
          component_separators = { "", "" },
          globalstatus = true, -- Pour une barre unique globale
        },
        winbar = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
        },
        inactive_winbar = {
          lualine_a = {}, -- Garde la section vide pour alléger
          lualine_c = {
            {
              "filename",
              color = { fg = "#a9b1d6", bg = "#1a1b26" }, -- Texte blanc, bleu TokyoNight , bg = "#1a1b26"
            },
          },
        },
        sections = {},
      })
    end,
  },
}
