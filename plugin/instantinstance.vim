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
  exe ":normal o" . show2

endfunction

function Instancify (typeclass, typename) 
  let result = "derive instance " . tolower(a:typeclass) . a:typename . " :: " . a:typeclass . " " . a:typename 
  return result
endfunction

function WithStrategy (strategy)
  let typeclasses = input("Typeclass(es): ")
  let result = "  deriving " . a:strategy . " (" . typeclasses . ")"
  exe ":normal o" . result
endfunction

"so we have deriving strats, but not stand alone deriving

function StandAloneDerive()
  let typeclass = input("Typeclass: ")
  let typename  = input("Type name: ")
  if g:deriving_strategies_on
    let strategy = input("Strategy:")
    let result1 = "  deriving " . strategy . " instance " . typeclass . " " .typename
    exe ":normal o" . result1
  else
    let result2 = "  deriving instance " typeclass . " " . typename
    exe ":normal o" . result2
  endif

endfunction

function DeriveNewtypePurescript()
  let typeclass = input("Typeclass: ")
  let typename  = input("Type name: ")
  let result1 = "derive newtype instance " . tolower(typeclass) . typename . " :: " . typeclass . " " . typename
  exe ":normal o" . result1
endfunction

" haskell and purescript quick snippet mappings for common constructors
" alt-f for forall
inoremap <M-f> forall 
" alt-r for Array
inoremap <M-r> Array 
" alt-t for Tuple
inoremap <M-t> Tuple 

"Set haskell bindings
:augroup iibindings
:    autocmd!
:    autocmd FileType haskell nnoremap <leader>l i{-# LANGUAGE  #-}<Esc><<o<Esc>k$4ha
:    autocmd FileType haskell nnoremap <leader>i :call MakeHaskellInstance()<cr>
:    autocmd FileType haskell nnoremap <leader>de :call DeriveEverythingHaskell()<cr>
:    autocmd FileType haskell nnoremap <leader>ds :call WithStrategy("stock")<cr>
:    autocmd FileType haskell nnoremap <leader>dn :call WithStrategy("newtype")<cr>
:    autocmd FileType haskell nnoremap <leader>da :call WithStrategy("anyclass")<cr>
:    autocmd FileType haskell nnoremap <leader>dt :call StandAloneDerive()<cr>
:    autocmd FileType haskell imap <m-y> <Esc>:call AlignAboveHaskellStyle()<cr>i
:    autocmd FileType haskell nmap <leader>y :call AlignAboveHaskellStyle()<cr>
"set purescript bindings
:    autocmd FileType purescript nnoremap <leader>i :call MakePureScriptInstance()<cr>
:    autocmd FileType purescript nnoremap <leader>de :call DeriveEverythingPurescript()<cr>
:    autocmd FileType purescript nnoremap <leader>dn :call DeriveNewtypePurescript()<cr>
:    autocmd FileType purescript imap <m-y> <Esc>:call AlignAboveHaskellStyle()<cr>i
:    autocmd FileType purescript nmap <leader>y :call AlignAboveHaskellStyle()<cr>
:augroup END

function AlignAboveHaskellStyle() 
    :echom "starting alignment"
    let trigger = 0
    let lineAboveLength = strlen(getline(line('.') -1))
    " :echom "line above:"
    " :echom lineAboveLength
    while trigger == 0
      :normal kly1ljp
      let lastItem='"' . getline('.') . '"'
      " :echom lastItem
      let thisLineLength=strlen(getline('.'))
      " :echom "line length:"
      " :echom thisLineLength
      " :echom "lastItem:" 
      " :echom lastItem
      " if the last char is not a space or if current is bigger or equal than
      " line above
      if (lastItem !~ '\v.+\s+$' || thisLineLength >= lineAboveLength)
        :echom lastItem !~ '\v.+\s+$'
        " :echom thisLineLength >= lineAboveLength
        let trigger = 1
      endif
    endwhile
endfunction


