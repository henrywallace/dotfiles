require('illuminate').configure({under_cursor = false})

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.diagnostic.config({virtual_text = false})

local on_attach = function(client, bufnr)
    -- require('lsp_signature').on_attach({bind=true}, bufnr)
    -- lsp_status.on_attach(client)

    local opts = {noremap = true, silent = true}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',
                                '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
                                '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt',
                                '<cmd>lua vim.lsp.buf.type_definition()<CR>',
                                opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gd', ':vsplit<cr> | lua vim.lsp.buf.definition()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>gd',
                                ':vsplit<cr><c-w>w <bar> :vsplit', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd',
                                '<cmd>vsplit<CR><c-w><c-w>lua vim.lsp.buf.definition()<CR>',
                                opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',
                                '<cmd>TroubleToggle lsp_references<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',
                                '<cmd>TroubleToggle lsp_implementations<cr>',
                                opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'rn',
                                '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d',
                                '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d',
                                '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<s-p>',
                                '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

local caps = require('cmp_nvim_lsp').default_capabilities()

-- Use internal formatting for bindings like gq.
-- https://vi.stackexchange.com/a/39800/30678
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args) vim.bo[args.buf].formatexpr = nil end
})

local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.black, null_ls.builtins.formatting.deno_fmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.rustfmt, null_ls.builtins.formatting.taplo,
        null_ls.builtins.formatting.yamlfmt
        -- null_ls.builtins.formatting.lua_format
    },

    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        local ignore_filetypes = {markdown = true, txt = true}
        if client.supports_method("textDocument/formatting") then
            -- Ignore specified filetypes
            if ignore_filetypes[vim.api.nvim_buf_get_option(bufnr, 'filetype')] then
                return
            end

            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- vim.lsp.buf.formatting_sync()
                    vim.lsp.buf.format({bufnr = bufnr})
                end
            })
        end
    end
})

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Enable the following language servers
local servers = {
    gopls = {cmd = {"gopls", "-remote=auto", "-debug=:0", "-remote.debug=:0"}},
    -- sqls = {},
    pyright = {},
    rust_analyzer = {
        -- settings = {
        --   ["rust-analyzer"] = {
        --     lruCapacity = 32,
        --     checkOnSave = {
        --       allFeatures = true,
        --       -- overrideCommand = {
        --       --   "cargo",
        --       --   "clippy",
        --       --   "--workspace",
        --       --   "--message-format=json",
        --       --   "--all-targets",
        --       --   "--all-features",
        --       --   "--target-dir=/tmp/rust-analyzer-check", -- avoid cargo lock contention
        --       -- },
        --     },
        --   },
        -- },
    },
    denols = {},
    texlab = {},
    jsonls = {},
    svelte = {},
    yamlls = {
        settings = {
            schema = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"

            }
        }
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
                    path = runtime_path
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim', 'require'}
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true)
                },
                -- Do not send telemetry data containing a randomized but unique
                -- identifier.
                telemetry = {enable = false}
            }
        }
    }
}

for lsp, s in pairs(servers) do
    local setup = {
        on_attach = on_attach,
        capabilities = caps,
        -- handlers = lsp_status.extensions[lsp].setup(),
        flags = {debounce_text_changes = 100}
    }
    for k, v in pairs(s) do setup[k] = v end
    -- print(vim.inspect(setup))
    require('lspconfig')[lsp].setup(setup)
end

-- vim.cmd([[au BufWritePre *.go,*.rs lua vim.lsp.buf.formatting()]])
