# mado.vim

Make winnr visually clear.

## usage

### install
<pre>
# dein
call dein#add('takei0107/mado.vim')
</pre>

### command
<pre>
# show all winnr
:MadoShow
# hide all winnr
:MadoHide
</pre>

### settings
<pre>
# popup height (default: 3)
let g:mado#height = 5
# popup width (default: 5 + Numer of digits of winnr - 1) 
let g:mado#width = 6
</pre>
