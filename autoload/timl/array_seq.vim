" Maintainer: Tim Pope <http://tpo.pe>

if exists("g:autoloaded_timl_array_seq")
  finish
endif
let g:autoloaded_timl_array_seq = 1

function! timl#array_seq#create(array, ...) abort
  let cc = timl#type#bless('timl.lang/ArraySeq', {
        \ 'array': a:array,
        \ 'meta': g:timl#nil,
        \ 'i': a:0 ? a:1 : 0})
  lockvar 1 cc
  return cc
endfunction

function! timl#array_seq#first(seq) abort
  return get(a:seq.array, a:seq.i, g:timl#nil)
endfunction

function! timl#array_seq#more(seq) abort
  if len(a:seq.array) - a:seq.i <= 1
    return g:timl#empty_list
  else
    return timl#array_seq#create(a:seq.array, a:seq.i+1)
  endif
endfunction

function! timl#array_seq#length(this) abort
  return len(a:this.array) - a:this.i
endfunction

let s:chunk_size = 32

function! timl#array_seq#chunk_first(this) abort
  return a:this.array[a:this.i : min([a:this.i+s:chunk_size, len(a:this.array)])-1]
endfunction

function! timl#array_seq#chunk_rest(this) abort
  if len(a:this.array) - a:this.i <= s:chunk_size
    return g:timl#empty_list
  else
    return timl#array_seq#create(a:this.array, a:this.i+s:chunk_size)
  endif
endfunction
