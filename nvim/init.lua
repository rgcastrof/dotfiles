-- Plugins List

vim.cmd([[
    call plug#begin()

    " General Plugins
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'goolord/alpha-nvim'
    Plug 'szw/vim-maximizer'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
    Plug 'numToStr/Comment.nvim'


    " Lsp's
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'

    " Autocompletion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'

    " Snippets
    Plug 'rafamadriz/friendly-snippets'
    Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
    Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v4.x'}

    " Themes
    Plug 'folke/tokyonight.nvim'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'ellisonleao/gruvbox.nvim'
    Plug 'navarasu/onedark.nvim'

    " Git
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'tpope/vim-fugitive'

    call plug#end()
]])


-- General settings
vim.cmd("syntax on")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set mouse=a")
vim.cmd("set scrolloff=8")
vim.cmd("set smartindent")
vim.cmd("set cursorline")
vim.cmd("set termguicolors")


-- colorscheme
require('onedark').setup {
    style = 'warmer'
}
require('onedark').load()

-- Transparency background and signcolumn
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight EndOfBuffer guibg=NONE ctermbg=NONE")
vim.cmd("highlight SignColumn guibg=NONE ctermbg=NONE")


-- Bufferline
require("bufferline").setup {
    options = {
        always_show_bufferline = false,
    }
}


-- Lualine
require('lualine').setup {
    options = { theme = 'onedark' }
}


-- Telescope
require('telescope').setup {
    defaults = {
        layout_strategy = 'center',
        layout_config = {
            prompt_position = 'bottom',
            width = 0.5,
            anchor = "N",
        },
        sorting_strategy = "ascending",
    }
}


-- Treesiter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "java", "go"},

  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}


-- Indent blankline
require("ibl").setup {
    indent = {
        char = "┊",
    },
    scope = {
        show_start = false,
        show_end = false,
    }
}


-- Alpha-nvim(dashboard)
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
"                                                                             ",
"██╗   ██╗██╗    ███╗   ███╗██████╗ ██████╗  ██████╗ ██╗   ██╗███████╗██████╗ ",
"██║   ██║██║    ████╗ ████║██╔══██╗██╔══██╗██╔═══██╗██║   ██║██╔════╝██╔══██╗",
"██║   ██║██║    ██╔████╔██║██████╔╝██████╔╝██║   ██║██║   ██║█████╗  ██║  ██║",
"╚██╗ ██╔╝██║    ██║╚██╔╝██║██╔═══╝ ██╔══██╗██║   ██║╚██╗ ██╔╝██╔══╝  ██║  ██║",
" ╚████╔╝ ██║    ██║ ╚═╝ ██║██║     ██║  ██║╚██████╔╝ ╚████╔╝ ███████╗██████╔╝",
"  ╚═══╝  ╚═╝    ╚═╝     ╚═╝╚═╝     ╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚══════╝╚═════╝ ",
"                                                                             ",
"                                                                             ",
}

dashboard.section.buttons.val = {
  dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
  dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
  dashboard.button("u", "  > Update", ":PlugUpdate<CR>"),
  dashboard.button("s", "  > Settings", ":edit $HOME/.config/nvim/init.lua<CR>"),
  dashboard.button("q", "  > Quit", ":qa<CR>"),
}

dashboard.section.footer.val = {
    "",
    "Não peço um fardo mais leve,",
    "mas ombros mais fortes.",
}
dashboard.section.footer.opts.hl = "Comment"

alpha.setup(dashboard.opts)


-- Lsps
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "clangd", "jdtls", "gopls" },
}
local lspconfig = require('lspconfig')

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

-- Lsp's setup
lspconfig.lua_ls.setup {}
lspconfig.clangd.setup {}

-- LSP Configuration (GO)
lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"gopls"},
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
}

-- LSP Configuration (JDTLS)
require('lspconfig').jdtls.setup({
  on_attach = function(client, bufnr)
    -- Deactivate semanticTokensProvider for JDTLS
    if client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- Deactivate semanticTokensProvider for all LSPs after activation
-- for treesiter works correctly with java
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-->'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<C-=>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
        vim.snippet.expand(args.body)
    end,
  },
})


-- Add signs icons
local x = vim.diagnostic.severity

vim.diagnostic.config {
    virtual_text = { prefix = "a" },
    signs = { text = { [x.ERROR] = " ", [x.WARN] = " ", [x.INFO] = " ", [x.HINT] = "󰠠 " } },
    underline = true,
}


-- Gitsigns
require('gitsigns').setup()

-- Comment
require('Comment').setup()


-- macros
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- telescope
vim.cmd("nnoremap <C-p> <cmd>Telescope find_files<cr>")

-- buffers management
map("n", "<C-l>", ":bnext<CR>", opts)
map("n", "<C-h>", ":bprevious<CR>", opts)
map("n", "<C-q>", ":q<CR>", opts)
map("n", "<C-s>5", ":vnew<CR>", opts)
map("n", "<C-s>'", ":new<CR>", opts)
map("n", "<C-s>z", ":MaximizerToggle<CR>", opts)
map("n", "<C-s>t", ":belowright new<CR>:terminal<CR>:resize 10<CR>", opts)
map("n", "<C-b>",   ":Vexplore 30<CR>", opts)


-- git maps
map ("n", "<C-g>", ":G<CR>", opts)
map ("n", "<C-g>a", ":G add .<CR>", opts)
map ("n", "<C-g>c", ":G commit -a -m ", opts)

-- remaps
vim.cmd("map <C-s>h <C-w>h")
vim.cmd("map <C-s>l <C-w>l")
vim.cmd("map <C-s>k <C-w>k")
vim.cmd("map <C-s>j <C-w>j")
