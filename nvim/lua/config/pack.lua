vim.pack.add({
  { src = "https://github.com/bluz71/vim-moonfly-colors", name = "moonfly" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
})

require("plugins.colors")
require("plugins.oil")
require("plugins.telescope")
require("plugins.harpoon")
require("plugins.lsp")
require("plugins.nvim-cmp")
require("plugins.lualine")
