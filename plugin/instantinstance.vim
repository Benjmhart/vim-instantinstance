"write a function for haskell
"write a function for ps with the same interface
"write a function which checks for haskell/ps file
if exists("g:loaded_instantinstance_plugin")
  finish
endif

let g:loaded_instantinstance_plugin = 1

function MakeHaskellInstance()
  let typeclass = input("Typeclass: ")
  let typename  = input("Type name: ")
  let instance  = "instance " . typeclass . " " . typename . " where"
  exe ":normal o" . instance 
endfunction

function MakePureScriptInstance()
  let typeclass = input("Typeclass: ")
  let typename  = input("Type name: ")
  let withoutVars = GetTypenameWithoutVariables(typename)
  let instance  = "instance " . tolower(withoutVars) . typename . " :: " . typeclass . " " . typename . " where"
  exe ":normal! o" . instance 
endfunction

function GetTypenameWithoutVariables(str) 
  return substitute(split(str)[0], "(", "", "g")
endfunction
" we need a way to deal with brackets

"drop anything after the first space  

" we need deriving statements


autocmd FileType haskell nnoremap <leader>i :call MakeHaskellInstance()<cr>
autocmd FileType purescript nnoremap <leader>i :call MakePureScriptInstance()<cr>

nnoremap <leader>sop :source %<cr>
