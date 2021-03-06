" File ~/.vimrc

call plug#begin('~/.config/vim/plugged')

Plug 'tpope/vim-sensible'

" General
Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'kshenoy/vim-signature'
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'

" In-file searching ala 'ack'
Plug 'gabesoft/vim-ags'

" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Syntax highlighting
Plug 'saltstack/salt-vim'
Plug 'stephpy/vim-yaml'
Plug 'fatih/vim-go'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'pangloss/vim-javascript'
Plug 'Chiel92/vim-autoformat'
Plug 'mutewinter/nginx.vim'
Plug 'othree/html5.vim'
Plug 'leshill/vim-json'
Plug 'digitaltoad/vim-pug'
Plug 'ekalinin/Dockerfile.vim'

" Code folding for Python
Plug 'tmhedberg/SimpylFold'

" Javascript stuff
Plug 'heavenshell/vim-jsdoc'

" Ctags tagbar
Plug 'majutsushi/tagbar'

" Allow better soft-wrapping of text in prose-based
" formats e.g. markdown.
Plug 'reedes/vim-pencil'

" The all-important colorscheme
Plug 'altercation/vim-colors-solarized'
Plug '29decibel/codeschool-vim-theme'
Plug 'morhetz/gruvbox'

call plug#end()


" Colorscheme
set background=dark
colorscheme gruvbox

" highlight current window
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

" All key mappings
""""""""""""""""""

" Hail to the <leader>
let mapleader = ","

" Ignore case in search
set ignorecase!
set hlsearch

" Only hide buffers when changing between them;
" this way we can keep their undo histories.
set hidden

" NERDTree toggle
noremap <leader>t :NERDTreeToggle<CR>

" Run manual syntastic check
noremap <F8> :TagbarToggle<CR>

" Toggle highlight on ,/
nnoremap <leader>/ :set hlsearch!<CR>

" Map main trigger for fuzzy file finder
noremap <C-p> :FZF<CR>

" Tagbar/ctags
nmap <F2> :TagbarToggle<CR>

" General code style settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Python specific configs
"""""""""""""""""""""""""

" We like spaces; avoid tabs
autocmd FileType python setlocal shiftwidth=4 expandtab tabstop=4 softtabstop=4

" Remind ourselves to keep Python code to < 80 cols
autocmd FileType python setlocal colorcolumn=80
" Omnifunc for python
autocmd FileType python set omnifunc=pythoncomplete#Complete

" JavaScript specific configs
"""""""""""""""""""""""""""""

autocmd FileType javascript setlocal shiftwidth=4 expandtab tabstop=4 softtabstop=4
autocmd FileType javascript setlocal colorcolumn=99

" JSDoc config

let g:jsdoc_enable_es6=1


" NERDTree settings
let NERDTreeIgnore = ['\.pyc$', '\.egg$', '\.o$', '\~$', '__pycache__$', '\.egg-info$']
let NERDTreeShowHidden =1
au VimEnter * NERDTree
au VimEnter * NERDTreeTabsOpen

" Syntax checker options
let g:flake8_ignore="E128,E501"

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_jump = 0
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_disabled_filetypes=['html', 'jinja']
let g:syntastic_python_flake8_args='--ignore=E501,E128'
let g:syntastic_scss_checkers = ['scss_lint']

" Load checkers which have configuration present
function! JavascriptCheckers()
  let checkers = []
  if filereadable(getcwd() . '/.jscsrc')
    call add(checkers, 'jscs')
  endif

  if filereadable(getcwd() . '/.jshintrc')
    call add(checkers, 'jshint')
  endif

  " look for the closest eslintrc file up the tree
  if findfile('.eslintrc', '.;') != ''
    echo "adding eslint"
    call add(checkers, 'eslint')
  endif

  " Use the locally installed eslint if it exists
  if findfile(getcwd() . '/node_modules/.bin/eslint') != ''
    echo "using local eslint"
    let b:syntastic_javascript_eslint_exec = getcwd() . '/node_modules/.bin/eslint'
  endif

  return checkers
endfunction

if findfile(getcwd() . '/node_modules/.bin/eslint') != ''
  let b:syntastic_javascript_eslint_exec = getcwd() . '/node_modules/.bin/eslint'
endif
"let g:syntastic_javascript_checkers=['jscs', 'eslint', 'jshint']
let g:syntastic_javascript_checkers=[]
autocmd FileType javascript let b:syntastic_checkers = JavascriptCheckers()

hi Search ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
hi SpellBad ctermfg=15 ctermbg=9 guifg=White guibg=Red
hi Folded term=bold ctermfg=85 ctermbg=234 gui=bold guifg=#9cffd3 guibg=#202020

" Map main trigger for fuzzy file finder
let g:fzf_height = '30%'

" I CAN HAZ NORMAL REGEXES?
nnoremap / /\v
vnoremap / /\v

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Special characters for hilighting non-priting spaces/tabs/etc.
set list listchars=tab:»\ ,trail:·

" Automatically populate the g:airline_symbols dictionary with the powerline symbols.
let g:airline_powerline_fonts = 1

" Line numbers
set number

filetype plugin indent on


" Where swap and backup files go
set backupdir=~/.config/vim/backup_files//
set directory=~/.config/vim/swap_files//
set undodir=~/.config/vim/undo_files//

" Vim-Golang plugin configs
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" Code folding for pythonm
let g:SimpylFold_docstring_preview = 1
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

" Automatically strip trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Configure vim-pencil
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
                            \ | setl spell spl=en_us fdl=4 noru nonu nornu
                            \ | setl fdo+=search
  autocmd Filetype git,gitsendemail,*commit*,*COMMIT*
                            \   call pencil#init({'wrap': 'hard', 'textwidth': 72})
                            \ | setl spell spl=en_us et sw=2 ts=2 noai
  autocmd Filetype mail         call pencil#init({'wrap': 'hard', 'textwidth': 60})
                            \ | setl spell spl=en_us et sw=2 ts=2 noai nonu nornu
  autocmd Filetype html,xml     call pencil#init({'wrap': 'soft'})
                            \ | setl spell spl=en_us et sw=2 ts=2
augroup END

let g:airline_section_x = '%{PencilMode()}'

" Editorconfig exceptions
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" configuring colours
