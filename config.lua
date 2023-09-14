-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny



vim.keymap.set("n", "<C-s>", function() require("harpoon.mark").add_file() end)
vim.keymap.set("n", "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.g.user_emmet_leader_key = '<C-y>'

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

lvim.format_on_save = true

vim.g.copilot_no_tab = true
vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("CR")', { silent = true, expr = true })

local cmp_nvim_lsp = require "cmp_nvim_lsp"

require("lspconfig").clangd.setup {
    on_attach = on_attach,
    capabilities = cmp_nvim_lsp.default_capabilities(),
    cmd = {
        "clangd",
        "--offset-encoding=utf-16",
    },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { name = "black" },
    {
        name = "prettier",
        ---@usage arguments to pass to the formatter
        -- these cannot contain whitespace
        -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
        args = { "--print-width", "100" },
        ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
        filetypes = { "typescript", "typescriptreact" },
    },
}
lvim.plugins = {
    { "norcalli/nvim-colorizer.lua" },
    { "mattn/emmet-vim" },
    {
        "github/copilot.vim",
        event = "VeryLazy",
        config = function()
            -- copilot assume mapped
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_no_tab_map = true
        end,
    },
    { "theprimeagen/harpoon" },
    { "prisma/vim-prisma" },
    { "tpope/vim-fugitive" },
}
