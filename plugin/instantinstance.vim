"write a function for haskell
"write a function for ps with the same interface
"write a function which checks for haskell/ps file
if exists("g:loaded_instantinstance_plugin")
  finish
endif

let g:loaded_instantinstance_plugin = 1

let g:deriving_strategies_on = 1

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
  let instance  = "instance " . tolower(typeclass) . withoutVars . " :: " . typeclass . " " . typename . " where"
  exe ":normal! o" . instance 
endfunction

function GetTypenameWithoutVariables(str) 
  let list = split(a:str)
  let first = list[0]
  let result = substitute(first, "(", "", "g")
  return result
endfunction

function DeriveEverythingHaskell()
  if g:deriving_strategies_on
    let instanceText1a = "  deriving stock (Eq, Ord, Show, Read, Generic)"
    let instanceText1b = "  deriving anyclass (ToJSON, FromJSON)"
    exe ":normal o" . instanceText1a . "\n" . instanceText1b
  else
    let instanceText2 = "deriving (Eq, Ord, Show, Read, Generic, ToJSON, FromJSON)"
    exe ":normal o" . instanceText2
  endif
endfunction

function DeriveEverythingPurescript()

  let typename  = input("Type name: ")
  let eq = Instancify("Eq", typename)
  exe ":normal o" . eq
  let ord = Instancify("Ord", typename)
  exe ":normal o" . ord
  let generic = Instancify("Generic", typename)
  exe ":normal o" . generic . " _" 
  let newtype = Instancify("Newtype", typename)
  exe ":normal o" . newtype
  let show = "instance show" . typename . " :: Show " . typename . " where"
  exe ":normal o" . show
  let show2 = "  show x = genericShow x"

endfunction

function Instancify (typeclass, typename) 
  return "derive instance " . tolower(a:typeclass) . a:typename . " :: " a:typeclass . " " . a:typename 
endfunction
" we need deriving statements
" de- derive everything with correct strategies
"
" ds - derive stock
" dn - derive newtype
" da - derive anyclass



"Set haskell bindings
autocmd FileType haskell nnoremap <leader>i :call MakeHaskellInstance()<cr>
autocmd FileType haskell nnoremap <leader>de :call DeriveEverythingHaskell()<cr>

"set purescript bindings
autocmd FileType purescript nnoremap <leader>i :call MakePureScriptInstance()<cr>
autocmd FileType purescript nnoremap <leader>de :call DeriveEverythingPurescript()<cr>


nnoremap <leader>sop :source %<cr>
