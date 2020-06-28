"write a function for haskell
"write a function for ps with the same interface
"write a function which checks for haskell/ps file

function MakeHaskellInstance()
  let typeclass = input("Typeclass: ")
  let typename  = input("Type name: ")
  let instance  = "instance " . typeclass . " " . typename . " where"
  exe ":normal o" . instance 
endfunction

function MakePureScriptInstance()
  let typeclass = input("Typeclass: ")
  let typename  = input("Type name: ")
  let instance  = "instance " . tolower(typeclass) . typename . " :: " . typeclass . " " . typename . " where"
  exe ":normal! o" . instance 
endfunction

" filetypes are setup for purescript and haskell
"

function MakeInstance()
  if (&ft=='haskell')
    exe ":call MakeHaskellInstance()"
  endif
  if (&ft=='purescript')
    exe ":call MakePureScriptInstance()"
  endif
endfunction

nnoremap <leader>i :call MakeInstance()<cr>
nnoremap <leader>sop :source %<cr>
