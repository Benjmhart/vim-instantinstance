# Instant Instance

this is a quick and easy way to write typeclass instance boilerplate in the haskell or purescript programming languages:

usage:
(note: you must be able to detect haskell and purescript filetypes,  run `:set filetype?` to see if your filetypes are correctly detected)

for VimPlug - add the following to your vimrc in the plugin block:
`Plug 'benjmhart/vim-instantinstance'`

then, while editing a haskell or purescript file.  hit `<leader>i` and you will be prompted to type the instance and the data type.


new Features July 2020:
 - better bracket handling - esp for purescript named instances 
 - derived instances features

new Features December 2020:
 - insert and normal mode bindings to enable vertical alignment:
  
  to use the alignment tool, in insert mode press <m-y> (alt-y), or in normal mode press <leader>y
  (y is chosen to match the existing <c-y> binding in insert mode to copy from above)
  
  this will take you from here:
  
  ```
    Record
      { name         :: String
      , thing
  ```
  to here:
  
  ```
    Record
      { name         :: String
      , thing        :
  ```
  this works for any whitespace gap followed by a character

 - use <leader>rw to replace a word with whitespace
 - use <leader>q to replace whitespace with the keyword 'qualified'


 
Derived instances:

press `<leader>de` to derive everything - this provides a deriving block which includes the most common typeclasses.   In haskell and not using deriving strategies?   set `g:deriving_strategies_on = 0` and you will get a more traditional deriving statement

press `<leader>dn` for a deriving statement using the newtype strategy
press `<leader>da` for a deriving statement using the anyclass strategy
press `<leader>ds` for a deriving statement using the stock strategy

press `<leader>dt>` for a stand-alone deriving statement, you may be prompted for a strategy
# Short term features we want to add:
- recommend typeclasses from a list of the most common ones
- recommend Datatypes from open file
- language pragma and type signature snippets
- autocomplete matching on a common dictionary
- speed up input - seems to be a delay in the function?
