-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}
-- https://github.com/RayJameson/astronvim_config/blob/main/polish.lua
-- https://blog.csdn.net/weixin_44609676/article/details/129991902
vim.cmd [[
    autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.go,*.py exec ":call SetTitle()"
    """定义函数SetTitle，自动插入文件头
    func SetTitle()
        "如果文件类型为.sh文件
        if &filetype == 'sh'
            call setline(1,  "\#!/bin/bash")
            call append(".",         "\#####################################################")
            call append(line(".")+1, "\#  > File Name:     ".expand("%"))
            call append(line(".")+2, "\#  > Author:        wqk")
            call append(line(".")+3, "\#  > mail:          wqk@example.com")
            call append(line(".")+4, "\#  > Created Time:  ".strftime("%c"))
            call append(line(".")+5, "\#  > Description:   ")
            call append(line(".")+6, "\#####################################################")
            call append(line(".")+7, "")
        elseif &filetype == 'python'
            call setline(1, "\#!/usr/bin/env python")
            call append(line("."), "\# -*- coding:utf-8 -*-")
            call append(line(".")+1, "\#####################################################")
            call append(line(".")+2, "\#  > File Name:     ".expand("%"))
            call append(line(".")+3, "\#  > Author:        wqk")
            call append(line(".")+4, "\#  > Mail:          wqk@example.com")
            call append(line(".")+5, "\#  > Created Time:  ".strftime("%c"))
            call append(line(".")+6, "\#  > Version:       python 3.10")
            call append(line(".")+7, "\#  > Description:   ")
            call append(line(".")+8, "\######################################################")
            call append(line(".")+9,"")
        elseif &filetype == 'go'
            call setline(1, "\//####################################################")
            call append(line("."),   "\// > File Name:     ".expand("%"))
            call append(line(".")+1, "\// > Author:        wqk")
            call append(line(".")+2, "\// > Mail:          wqk@example.com")
            call append(line(".")+3, "\// > Created Time:  ".strftime("%c"))
            call append(line(".")+4, "\// > Version:       gloang 1.18")
            call append(line(".")+5, "\// > Description:   ")
            call append(line(".")+6, "\//######################################################")
            call append(line(".")+7,"")
        else
            call setline(1, "/*####################################################")
            call append(line("."),   "\#  > File Name:     ".expand("%"))
            call append(line(".")+1, "\#  > Author:        wqk")
            call append(line(".")+2, "\#  > mail:          wqk@example.com")
            call append(line(".")+3, "\#  > Created Time:  ".strftime("%c"))
            call append(line(".")+4, "\#  > Description:   ")
            call append(line(".")+5, "\######################################################*/")
            call append(line(".")+6, "")
        endif
        "新建文件后，自动定位到文件末尾
        normal G
        normal o
    endfunc
    ]]
vim.cmd [[
    autocmd BufNewFile *.h,*.hpp exec ":call AddHHeader()"
    func AddHHeader()
        let macro = "_".toupper(substitute(expand("%"), "[/.]", "_", "g"))."_"
        "normal o
        call setline(9, "#ifndef ".macro)
        call setline(10, "#define ".macro)
        call setline(11, "")
        call setline(12, "#endif  // ".macro)
    endfunc
    ]]
--     vim.cmd [[
--     hi tklink ctermfg=72 guifg=#0064cf cterm=bold,underline gui=bold,underline
--     hi tkBrackets ctermfg=gray guifg=gray
--
--     " real yellow
--     " hi tkHighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold
--     " gruvbox
--     " hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold
--
--     hi link CalNavi CalRuler
--     hi tkTagSep ctermfg=gray guifg=gray
--     hi tkTag ctermfg=175 guifg=#aabd2f
-- ]]
-- 在保存 Python 文件时将tab转换为四个空格
-- vim.cmd [[autocmd FileType python autocmd BufWritePre <buffer> set tabstop=4]]
-- vim.cmd [[autocmd FileType python autocmd BufWritePre <buffer> set expandtab]]
-- vim.cmd [[autocmd FileType python autocmd BufWritePre <buffer> set shiftwidth=4]]
-- vim.cmd [[autocmd FileType python autocmd BufWritePre <buffer> %retab!]]
