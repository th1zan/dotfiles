-- Code Tree Support / Syntax Highlighting
return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  dependencies = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  opts = {
    highlight = {
      enable = true,
      disable = { "tex" }, -- Désactive Tree-sitter pour les fichiers .tex
    },
    indent = { enable = true },
    auto_install = true, -- automatically install syntax support when entering new file type buffer
    ensure_installed = {
      "lua",
      -- Ajoute d'autres langages si nécessaire, par exemple :
      "python",
      "javascript",
      "typescript",
      "c",
      "cpp",
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump to the next textobject if the cursor is not exactly on it
        keymaps = {
          ["af"] = "@function.outer", -- Sélectionne la fonction entière (autour)
          ["if"] = "@function.inner", -- Sélectionne l'intérieur de la fonction (optionnel, pour info)
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- Permet d'utiliser les jumps (comme [m et ]m)
        goto_next_start = {
          ["]m"] = "@function.outer", -- Aller au début de la prochaine fonction
        },
        goto_previous_start = {
          ["[m"] = "@function.outer", -- Aller au début de la fonction précédente
        },
      },
    },
  },
  config = function(_, opts)
    local configs = require("nvim-treesitter.configs")
    configs.setup(opts)
  end,
}
