return require('packer').startup(function(use)
	
	use { "catppuccin/nvim", as = "catppuccin" }

	-- Configurations will go here soon
 	use 'wbthomason/packer.nvim'

    -- File explorer tree
 use {
  'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
 }

 use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = false }
}

use 'itchyny/lightline.vim'

use { 
  'nvim-treesitter/nvim-treesitter', 
  run = ':TSUpdate'

}

use({
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!:).
  run = "make install_jsregexp"
})

use {
        "hrsh7th/nvim-cmp",
        requires = {
          "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
            'hrsh7th/cmp-nvim-lua',
            'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
            'hrsh7th/cmp-emoji'
        }
    }

end)


