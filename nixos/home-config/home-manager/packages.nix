{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ansible        # Used for non-Nix VMs
    chromium
    cider          # Apple Music for Linux
    git
    joplin-desktop # Notebook
    virtualenv

    ((vim_configurable.override {}).customize {
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [
           vim-pathogen
           vim-colors-solarized
           syntastic
        ];
        opt = [];
      };
      vimrcConfig.customRC = ''
        set encoding=utf8
        set bg=dark
        set number
        set ruler
        set colorcolumn=+1
        set bs=indent,eol,start
        autocmd Filetype go setlocal tw=79 ts=4 sw=4 softtabstop=4 autoindent expandtab
        autocmd Filetype html setlocal tw=80 ts=2 sw=2 softtabstop=2 autoindent expandtab
        autocmd Filetype markdown setlocal tw=80 ts=2 sw=2 softtabstop=2 autoindent expandtab linebreak
        autocmd Filetype python setlocal tw=79 ts=4 sw=4 softtabstop=4 autoindent expandtab fileformat=unix
        autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
        autocmd Filetype rust setlocal tw=100 ts=4 sw=4 softtabstop=4 autoindent expandtab fileformat=unix
        autocmd Filetype sh setlocal ts=2 sw=2 expandtab
        autocmd Filetype vim setlocal tw=100 expandtab
        nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
        nnoremap <C-J> <C-W><C-J>
        execute pathogen#infect()
        syntax on
        filetype plugin indent on
        let g:solarized_termtrans = 1
        let g:vim_markdown_folding_disabled = 1
        let g:markdown_fenced_languages = ['python', 'sh', 'yaml', 'ruby', 'go', 'rust']
        colorscheme solarized
        highlight ColorColumn ctermbg=16 guibg=#D80000
        '';
    })
  ];
}
