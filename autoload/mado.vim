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
    let winnr = bufwinnr(bufnr)
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
    let bufnr = str2nr(trim(split(trimed, '\s\+')[0], 'u'))
    call add(bufnrs, bufnr)
  endfor
  return sort(bufnrs, 'n')
endfunction

function! s:show_float(winnr, winid)
  let buf = nvim_create_buf(v:false, v:true)
  let winnr_str = string(a:winnr)
  let height = 3
  let width = 5 + (strlen(winnr_str) - 1)
  let win_width = nvim_win_get_width(a:winid)
  let start_col = win_width - width
  let pos_x = float2nr(ceil(width / 2))
  let pos_y = float2nr(ceil(height / 2))
  let text = ''
  let i = 0
  while i < height
    let j = 0 
    while j < width
      if i == pos_y && j == pos_x
        let text = text .. winnr_str
      else
        let text = text .. ' '
      endif
      let j = j + 1
    endwhile
    if j < height - 1 
      let text = text .. '\n'
    endif
    let i = i + 1
  endwhile
  call nvim_buf_set_lines(buf, 0, -1, v:true, [text])
  let opts = {
    \ 'relative' : 'win',
    \ 'win' : a:winid,
    \ 'height' : height,
    \ 'width' : width,
    \ 'col' : start_col,
    \ 'row' : 0,
    \ 'focusable' : v:false,
    \}
  let float_win = nvim_open_win(buf, v:false, opts)
endfunction
