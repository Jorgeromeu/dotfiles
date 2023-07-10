-- load common settings
vim.cmd('source ~/dotfiles/nvim/common.vim')

-- plugins
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
    
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-commentary'
  use 'sheerun/vim-polyglot'
  -- use 'p00f/nvim-ts-rainbow'

end)

-- require("nvim-treesitter.configs").setup {
--   highlight = {
--       -- ...
--   },
--   -- ...
--   rainbow = {
--     enable = true,
--     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
--     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
--     max_file_lines = nil, -- Do not enable for files with more than n lines, int
--     -- colors = {}, -- table of hex strings
--     -- termcolors = {} -- table of colour name strings
--   }
-- }
