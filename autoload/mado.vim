" TODO 検討:引数の値で特定のウィンドウ or バッファのwinnrを返す？
function! mado#show_mado() abort
  let appeared_winnrs = s:get_appeared_winnr_list()
  for winnr in appeared_winnrs
    let winid = win_getid(winnr)
    call s:show_float(winnr, winid)
  endfor
endfunction

function! s:get_appeared_winnr_list() abort
  let winnrs = []
  let bufnrs = s:get_appeared_bufnr_list()
  for bufnr in bufnrs
    let winnr = bufwinnr(str2nr(bufnr))
    call add(winnrs, winnr)
  endfor
  return sort(winnrs, 'n')
endfunction

function! s:get_appeared_bufnr_list() abort
  let bufnrs = []
  redir => buffers
  silent buffers! a
  redir END
  let splited = split(copy(buffers), '\n')
  for buf in splited
    let trimed = trim(buf)
    let bufnr = trim(split(trimed, '\s\+')[0], 'u')
    call add(bufnrs, bufnr)
  endfor
  return sort(bufnrs, 'n')
endfunction

function! s:show_float(winnr, winid)
  let win_width = nvim_win_get_width(a:winid)
  " FIXME col,row算出
  let start_col = (win_width / 2) - 1
  let win_height = nvim_win_get_height(a:winid)
  let start_row = (win_height / 2) - 1
  let buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(buf, 0, -1, v:true, [string(a:winnr)])
  let opts = {
    \ 'relative' : 'win',
    \ 'win' : a:winid,
    \ 'height' : 3,
    \ 'width' : 9,
    \ 'col' : start_col,
    \ 'row' : start_row,
    \ 'focusable' : v:false,
    \}
  let float_win = nvim_open_win(buf, v:false, opts)
endfunction
