" Enable syntax highlighting
if has("syntax")
        syntax on
endif

" Tab and indentation-related settings
" https://stackoverflow.com/a/1878983
set tabstop=2 " Set the width of the `Tab` character to 2 spaces
set expandtab " Make the tab key insert spaces instead of tab characters
set autoindent " New lines inherit the indentation of previous lines

" Line numbering and highlighting
set number
set relativenumber
set ruler
highlight LineNr ctermfg=grey

" User interface
set laststatus=2 " Include a status bar along the bottom of the screen
