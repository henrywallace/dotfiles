require('illuminate').configure({
  under_cursor = false,
})

-- -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.diagnostic.config({
  virtual_text = false,
})

local on_attach = function(client, bufnr)
  -- require('lsp_signature').on_attach({bind=true}, bufnr)
  -- lsp_status.on_attach(client)

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gd', ':vsplit<cr> | lua vim.lsp.buf.definition()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gd', ':vsplit<cr><c-w>w <bar> :vsplit', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>vsplit<CR><c-w><c-w>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>TroubleToggle lsp_references<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>TroubleToggle lsp_implementations<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<s-p>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

local caps = require('cmp_nvim_lsp').default_capabilities()

local null_ls = require("null-ls")
null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.golangci_lint,
    },
})


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Enable the following language servers
local servers = {
  gopls = {
    cmd = {
     "gopls",
     "-remote=auto",
     "-debug=:0",
     "-remote.debug=:0",
    },
  },
  sqls = {},
  pyright = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        lruCapacity = 32,
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            "cargo",
            "clippy",
            "--workspace",
            "--message-format=json",
            "--all-targets",
            "--all-features",
            "--target-dir=/tmp/rust-analyzer-check", -- avoid cargo lock contention
          },
        },
      },
    },
  },
  jsonls = {},
  yamlls = {
    settings = {
      schema = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",

      },
    },
  },
  lua_ls = {
    settings = {
      -- TODO: Format on save.
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim).
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim', 'use'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique
        -- identifier.
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

for lsp, s in pairs(servers) do
  local setup = {
    on_attach = on_attach,
    capabilities = caps,
    -- handlers = lsp_status.extensions[lsp].setup(),
    flags = {
      debounce_text_changes = 100,
    },
  }
  for k, v in pairs(s) do
    setup[k] = v
  end
  -- print(vim.inspect(setup))
  require('lspconfig')[lsp].setup(setup)
end

vim.cmd([[au BufWritePre *.go,*.rs lua vim.lsp.buf.formatting()]])
