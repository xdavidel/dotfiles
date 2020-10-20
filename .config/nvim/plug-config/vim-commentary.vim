function! Comment()
  if (mode() == "n" )
    execute "Commentary"
  else
    execute "'<,'>Commentary"
  endif
endfunction
vnoremap <silent> <leader>/ :call Comment()
