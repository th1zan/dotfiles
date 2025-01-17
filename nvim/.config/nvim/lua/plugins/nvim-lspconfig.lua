-- these pckages must be installed in the virtual environnement
-- pip install neovim
-- pip install debugpy
-- pip install isort

-- LSP Support
return {
  -- LSP Configuration
  -- https://github.com/neovim/nvim-lspconfig
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    -- LSP Management
    -- https://github.com/williamboman/mason.nvim
    { "williamboman/mason.nvim" },
    -- https://github.com/williamboman/mason-lspconfig.nvim
    { "williamboman/mason-lspconfig.nvim" },

    -- Auto-Install LSPs, linters, formatters, debuggers
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },

    -- Useful status updates for LSP
    -- https://github.com/j-hui/fidget.nvim
    { "j-hui/fidget.nvim", opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    -- https://github.com/folke/neodev.nvim
    -- { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      -- Install these LSPs automatically
      ensure_installed = {
        "bashls",
        "cssls",
        "html",
        "lua_ls",
        "jsonls",
        "lemminx",
        "marksman",
        "quick_lint_js",
        "yamlls",
        "pyright",
      },
      automatic_installation = true,
    })

    require("mason-tool-installer").setup({
      -- Install these linters, formatters, debuggers automatically
      ensure_installed = {
        "black",
        "debugpy",
        "flake8",
        "isort",
        "mypy",
        "pylint",
      },
    })

    -- There is an issue with mason-tools-installer running with VeryLazy, since it triggers on VimEnter which has already occurred prior to this plugin loading so we need to call install explicitly
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
    vim.api.nvim_command("MasonToolsInstall")

    local lspconfig = require("lspconfig")
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lsp_attach = function(client, bufnr)
      -- Create your keybindings here...
    end

    -- Call setup on each LSP server
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
        })
      end,
    })

    -- Lua LSP settings
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
        },
      },
    })

    -- Globally configure all LSP floating preview popups (like hover, signature help, etc)

    local original_open_floating_preview = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded" -- Définir une bordure arrondie
      return original_open_floating_preview(contents, syntax, opts, ...)
    end
  end,
}
