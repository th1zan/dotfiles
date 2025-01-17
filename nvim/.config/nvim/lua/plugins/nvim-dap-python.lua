return {
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap_python = require("dap-python")
      -- Spécifiez le chemin correct vers Python
      dap_python.setup("/Users/thibault/kdrive/1-PROJECTS/P-42/transcendence/env/bin/python3")
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- Facultatif, utilisez cette section si une configuration est nécessaire
      local dap = require("dap")
      -- Exemple de configuration supplémentaire
      dap.defaults.fallback.terminal_win_cmd = "belowright new"
    end,
  },
}

-- https://www.youtube.com/watch?v=jWZ_JeLgDxU&t=387s
