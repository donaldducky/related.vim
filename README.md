related.vim
===========

A vim plugin for opening a related file based on the file path.

Commands
--------

There are two commands currently exposed:

1. `:RelatedFile` - Opens the related file in a vertical split
2. `:RelatedTests` - Runs the unit tests for the plugin

Workflow
--------

1. Open a source file.
2. Hit a key to open the related test file.

I bind the `:RelatedFile` command to a `<leader>` mapping in my `.vimrc`:

    " Open the related file using ,rf
    let mapleader = ","
    let g:mapleader = ","
    map <Leader>rf :RelatedFile<CR>

Inspiration
-----------

I spend far too much time navigating/opening related files that are easy to determine programmatically.

Creating a vim plugin would be the best way to do it but I didn't know how...luckily I stumbled across a post that was created to achieve the same thing:

[Optimize Your TDD Workflow by Writing Vim Plugins](http://www.vimninjas.com/2012/09/06/related-file/)

It was a good basis for showing me how to create a vim plugin and seeing how little code it was made me dive in.
