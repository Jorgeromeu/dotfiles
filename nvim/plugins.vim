call plug#begin('~/dotfiles/nvim/runtime/plugged')
" utility
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'sirver/UltiSnips'
Plug 'plasticboy/vim-markdown'
Plug 'jiangmiao/auto-pairs'

" aesthetics
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'arcticicestudio/nord-vim'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" ------------------
" plugin configuration
" ------------------

" commentary
autocmd FileType vhdl setlocal commentstring=--\ %s

" Goyo
map <C-f> :Goyo<CR>

" UltiSnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/dotfiles/nvim/runtime/snips']
let g:UltiSnipsExpandTrigger = '<C-L>'
let g:UltiSnipsJumpForwardTrigger = '<C-L>'
let g:UltiSnipsJumpBackwardTrigger = '<C-h>'
let g:UltiSnipsEditSplit="horizontal"

" markdown
set conceallevel=2
let g:vim_markdown_folding_disabled = 1
let g:tex_conceal = ""
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_autowrite = 1
