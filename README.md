# Buffting.nvim

A buffer navigation plugin for Neovim. [WIP]

## About

There are about a million plugins attempting to solve the buffer navigation
problem. I don't pretend that this succeeds, but I just wanted something that
felt good to me.

Taking liberal inspiration from
[`ThePrimeagen/harpoon`](https://github.com/ThePrimeagen/harpoon) and
[`akinsho/bufferline.nvim`](https://github.com/akinsho/bufferline.nvim/).

This plugin has a popup window that lets you select a buffer from the list of
open buffers and allows you to map keys to jump to individual buffers.

## Installation

Use whatever package manager you like.

For example, using `plug`:

```vim
Plug 'nvim-lua/plenary.nvim'
Plug 'rohanorton/buffting.nvim'
```

Or, my personal favourite, `packer`:

```lua
use({
  "rohanorton/buffting.nvim",
  requires = { "nvim-lua/plenary.nvim" }
})
```

Suggested keybindings:

```vim
noremap <silent> <leader><leader> <Plug>buffting-open-menu
noremap <silent> <leader>1 <Plug>buffting-jump-to-1
noremap <silent> <leader>2 <Plug>buffting-jump-to-2
noremap <silent> <leader>3 <Plug>buffting-jump-to-3
noremap <silent> <leader>4 <Plug>buffting-jump-to-4
noremap <silent> <leader>5 <Plug>buffting-jump-to-5
noremap <silent> <leader>6 <Plug>buffting-jump-to-6
noremap <silent> <leader>7 <Plug>buffting-jump-to-7
noremap <silent> <leader>8 <Plug>buffting-jump-to-8
noremap <silent> <leader>9 <Plug>buffting-jump-to-9
noremap <silent> <leader>0 <Plug>buffting-jump-to-10
```
