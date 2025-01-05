local util = require("lspconfig.util")

return {
  {
    "neovim/nvim-lspconfig",
    servers = {
      pylsp = {
        root_dir = function(fname)
          return util.root_pattern(".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt")(fname)
            or vim.fs.dirname(fname)
        end,
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                enabled = false,
                ignore = { "W391" }, -- Ignore l'avertissement W391 (ligne vide à la fin du fichier)
              },
              flake8 = {
                enabled = true,
                maxLineLength = 120,
                ignore = { "E501", "F401" }, -- Ignorer certains avertissements
              },
              pyflakes = { enabled = true },
              pylint = { enabled = false },
              jedi_rename = { enabled = true },
              jedi = {
                environment = vim.fn.getcwd() .. "/env", -- Utilise ton environnement virtuel
                extra_paths = {
                  vim.fn.getcwd() .. "/transcendance", -- Chemin vers ton projet Django
                },
              },
            },
          },
        },
      },
    },
  },
}
