" DEFAULT SET
set title						" Show filename
set showmode					" Show current mode
set showcmd						" Show command mode
set nocompatible				" Use Vim defaults (much better!)
set bs=2						" Allow backspacing over everything in insert mode
set ai							" Always set auto-indenting on
set history=50					" keep 50 lines of command history
set ruler						" Show the cursor position all the time
set viminfo='20,\"500			" Keep a .viminfo file
set pastetoggle=<F8>			" Toggle between paste mode on/off
set hlsearch					" Highlight search
set smartindent					" Set indention
set shiftwidth=4				" Shift width
set tabstop=4					" Tab size
set icon						" Icon text of the window
set confirm						" Extra dialog
set hlsearch					" Highlight searching result
set noincsearch					" Disable incremental searching
set ignorecase smartcase		" Case-insensitive searching
"set backup						" Backup options
"set backupdir=~/.vim/backup	" Backup dir

"spell checking
set spelllang=en,de				" Spell cheching language
set spellsuggest=double,10		" Description of the spell-checker
" zg to add word to word list
" zw to reverse
" zug to remove word from word list
" z= to get list of possibilities

" status line
set laststatus=2                " Always show the statusline
set t_Co=256                    " Explicitly tell vim that the terminal has 256 colors

"show tabs, EOL etc.
set lcs=tab:»·
set lcs+=trail:·
"set lcs+=eol:¶
set lcs+=precedes:«
set lcs+=extends:»
if v:version >= 700
    set lcs+=nbsp:·
endif

" Tab Wrapper function
function InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<tab>"
	else
		return "\<c-p>"
	endif
endfunction

" COLORSCHEME
colorscheme torte 

syntax on
map Q gq

" KEY MAPS
map <F2> :set spell!<CR><Bar>:echo "Spell check: " . strpart("OffOn", 3 * &spell, 3)<CR>
map <F3> :set cursorline!<CR><Bar>:echo "Highlight active cursor line: " . strpart("OffOn", 3 * &cursorline, 3)<CR>
map <F4> :set list!<CR><Bar>:echo "Display Tabs, EOL: " . strpart("OffOn", 3 * &list, 3)<CR>
map <F5> :set number!<CR><Bar>:echo "Display Number: " . strpart("OffOn", 3 * &number, 3)<CR>
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
nnoremap <C-N> :next<Enter>
nnoremap <C-P> :prev<Enter>
" HexMode
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>

" ENCODING
" Always check for UTF-8 when trying to determine encodings
if &fileencodings !~? "utf-8"
	set fileencodings+=utf-8
endif

" Make sure we have a sane fallback for encoding detection
set fileencodings+=default
