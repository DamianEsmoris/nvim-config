return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("conform").setup({ formatters_by_ft = {} })

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local bufnr = args.buf
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                end

                map('K', function()
                    local winid = require('vim.lsp.util').open_floating_preview(
                        {}, 'markdown', {}
                    )
                    vim.lsp.buf.hover()
                end, 'Hover docs')

                vim.keymap.set('n', 'K', function()
                    local _, winnr = vim.lsp.buf.hover()
                    if winnr then
                        vim.keymap.set('n', 'K', function()
                            vim.api.nvim_set_current_win(winnr)
                        end, { buffer = bufnr, noremap = true })
                        vim.api.nvim_create_autocmd('WinClosed', {
                            pattern = tostring(winnr),
                            once = true,
                            callback = function()
                                vim.keymap.set('n', 'K', function()
                                    vim.lsp.buf.hover()
                                end, { buffer = bufnr })
                            end,
                        })
                    end
                end, { buffer = bufnr, desc = 'Hover docs' })

                map('gd', vim.lsp.buf.definition, 'Go to definition')
                map('gv', function()
                    -- Abre split vertical y salta a la definición ahí
                    local params = vim.lsp.util.make_position_params()
                    vim.lsp.buf_request(bufnr, 'textDocument/definition', params, function(err, result, ctx)
                        if err or not result or vim.tbl_isempty(result) then return end
                        local loc = vim.islist(result) and result[1] or result
                        vim.cmd('vsplit')
                        vim.lsp.util.jump_to_location(loc, 'utf-8')
                    end)
                end, 'Go to definition (vsplit)')

                map(']d', function()
                    vim.diagnostic.goto_next({ float = true })
                end, 'Next diagnostic')
                map('[d', function()
                    vim.diagnostic.goto_prev({ float = true })
                end, 'Prev diagnostic')

                -- Solo errores (ignora warnings)
                map(']e', function()
                    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, float = true })
                end, 'Next error')
                map('[e', function()
                    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, float = true })
                end, 'Prev error')
            end,
        })

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {},
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup { capabilities = capabilities }
                end,
                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                },
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            float = {
                focusable = true,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
                max_width = 80, 
                wrap = true,
            },
            -- Fix 4: trunca el texto inline
            virtual_text = {
                spacing = 4,
                prefix = "●",
                format = function(diagnostic)
                    local msg = diagnostic.message
                    if #msg > 60 then
                        return msg:sub(1, 57) .. "..."
                    end
                    return msg
                end,
            },
        })
    end
}
