related.vim
===========

A vim plugin for opening a related file based on the file path.

Installation
------------

I prefer to use [Vundle](https://github.com/gmarik/vundle) but it's just as easy using other methods.

### Vundle

Install Vundle, following the [instructions](https://github.com/gmarik/vundle#quick-start).

Add the Bundle to your vimrc:

    Bundle 'donaldducky/related.vim'

Then run the `BundleInstall` from the command line:

    vim +BundleInstall +qall

### Pathogen

If you use [pathogen.vim](https://github.com/tpope/vim-pathogen), you can just clone the repo, manually.

    git clone https://github.com/donaldducky/related.vim ~/.vim/bundle/related.vim

Commands
--------

There are two commands currently exposed:

1. `:RelatedFile` - Opens the related file in a vertical split. Optionally accepts an argument to open the related file using other methods:
  * `:RelatedFile e` opens using `:e[dit]` command in the current window
  * `:RelatedFile sp` opens using `:sp[lit]` command in a horizontal split window
  * `:RelatedFile vs` opens using `:vs[plit]` command in a vertical split window
2. `:RelatedTests` - Runs the unit tests for the plugin.

Workflow
--------

1. Open a source file.
2. Hit a key to open the related test file.

I bind the `:RelatedFile` command to a `<leader>` mapping in my `.vimrc`:

    " Open the related file using ,rf
    let mapleader = ","
    let g:mapleader = ","
    map <Leader>rf :RelatedFile<CR>
    map <Leader>re :RelatedFile e<CR>
    map <Leader>rs :RelatedFile sp<CR>

Inspiration
-----------

I spend far too much time navigating/opening related files that are easy to determine programmatically.

Creating a vim plugin would be the best way to do it but I didn't know how...luckily I stumbled across a post that was created to achieve the same thing:

[Optimize Your TDD Workflow by Writing Vim Plugins](http://www.vimninjas.com/2012/09/06/related-file/)

It was a good basis for showing me how to create a vim plugin and seeing how little code it was made me dive in.
