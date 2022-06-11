if exists('g:loaded_mado')
  finish
endif
let g:loaded_mado = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=0 MadoShow call mado#show_mado()

let &cpo = s:save_cpo
unlet s:save_cpo
