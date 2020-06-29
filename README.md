# Instant Instance

this is a quick and easy way to write typeclass instance boilerplate in the haskell or purescript programming languages:

usage:
(note: you must be able to detect haskell and purescript filetypes,  run `:set filetype?` to see if your filetypes are correctly detected)

for VimPlug - add the following to your vimrc in the plugin block:
`Plug 'benjmhart/vim-instantinstance'`

then, while editing a haskell or purescript file.  hit `<leader>i` and you will be prompted to type the instance and the data type.



# Short term features we want to add:
- recommend typeclasses from a list of the most common ones
- recommend Datatypes from open file
- support for deriving strategies
- language pragma and type signature snippets
- autocomplete matching on a common dictionary
- speed up input - seems to be a delay in the function?
- recognize when to use brackets or omit type sigs
- multiparam typeclasses
