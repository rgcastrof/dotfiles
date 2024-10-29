vim.cmd([[
    "Plugins
    call plug#begin()

    " List your plugins here
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-neo-tree/neo-tree.nvim'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'goolord/alpha-nvim'
    Plug 'szw/vim-maximizer'

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
    Plug 'rebelot/kanagawa.nvim'
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'ellisonleao/gruvbox.nvim'
    Plug 'navarasu/onedark.nvim'
    Plug 'ayu-theme/ayu-vim'

    call plug#end()
]])

vim.cmd("syntax on")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set mouse=a")
vim.cmd("set scrolloff=8")
vim.cmd("set colorcolumn=80")
vim.cmd("set smartindent")
vim.cmd("set cursorline")
vim.cmd("set termguicolors")
vim.cmd("colorscheme onedark")


-- Lualine
require('lualine').setup {
  options = { theme = 'onedark' }
}

-- Treesiter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua","html", "css", "javascript", "python", "java", "rust"},

  sync_install = false,


  auto_install = true,

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled
    -- (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


-- Alpha-nvim(dashboard)
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local function footer()
  local datetime = os.date(" %A, %d de %B às %H:%M")

  return datetime
end

dashboard.section.header.val = {
"                                                                             ",
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

dashboard.section.footer.val = footer()

alpha.setup(dashboard.opts)


-- Lsps
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "jdtls" },
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

lspconfig.lua_ls.setup {}
lspconfig.clangd.setup {}
lspconfig.jdtls.setup {}
lspconfig.rust_analyzer.setup {}


local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Navigate between completion items
    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),

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

-- macros
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.cmd("nnoremap <C-f> <cmd>Telescope find_files<cr>")
vim.cmd("nnoremap <C-e> <cmd>Neotree toggle<cr>")

map("n", "<C-q>", ":bd<CR>", opts)
map("n", "<C-s>5", ":vnew<CR>", opts)
map("n", "<C-s>'", ":new<CR>", opts)
map("n", "<C-s>z", ":MaximizerToggle<CR>", opts)
map("n", "<C-s>t", ":belowright new<CR>:terminal<CR>:resize 10<CR>", opts)
map("n", "<C-p>", "vim.lsp.buf.hover", opts)
vim.cmd("map <C-h> <C-w>h")
vim.cmd("map <C-l> <C-w>l")
vim.cmd("map <C-k> <C-w>k")
vim.cmd("map <C-j> <C-w>j")
