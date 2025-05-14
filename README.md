# AstroNvim config v5

## AstroNvim repository

**NOTE:** This is for AstroNvim v4+

A template for getting started with [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Clone the repository

```bash
git clone https://github.com/wqk151/AstroNvim_v4.git ~/.config/nvim
```

## Environment

- neovim: v0.10.1
- node: v18.15.0
- python3: 3.10
- golang: go1.22

## Dependencies

```bash
apt update -y
apt install -y gcc g++ wget git curl python3-venv software-properties-common tree
```

## Install Neovim

```bash
sudo apt install gcc g++ make cmake pkg-config automake libtool libtool-bin unzip gettext
git clone https://github.com/neovim/neovim.git
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
nvim --version
```

## Some tools

```bash
# rg
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# chafa(optional)
https://hpjansson.org/chafa/releases/static/chafa-1.12.4-1-x86_64-linux-gnu.tar.gz

# pdftoppm(optional)
apt install poppler-utils

# ffmpeg
apt install ffmpeg

# nerd fonts
```

## Mappings

### General Mappings

| Action                                         | Mappings     |
| ---------------------------------------------- | ------------ |
| Leader key                                     | Space        |
| Local Leader key                               | ,            |
| Resize up                                      | Ctrl + Up    |
| Resize Down                                    | Ctrl + Down  |
| Resize Left                                    | Ctrl + Left  |
| Resize Right                                   | Ctrl + Right |
| Up Window                                      | Ctrl + k     |
| Down Window                                    | Ctrl + j     |
| Left Window                                    | Ctrl + h     |
| Right Window                                   | Ctrl + l     |
| Force Write                                    | Ctrl + s     |
| Force Quit                                     | Ctrl + q     |
| Close Buffer                                   | Leader + c   |
| Next Tab (real vim tab)                        | ]t           |
| Previous Tab (real vim tab)                    | [t           |
| Comment                                        | Leader + /   |
| Horizontal Split                               | `\`          |
| Vertical Split                                 | `\|`         |
| Open the link under cursor with system browser | gx           |
| Translate Word                                 | `,+t`        |

### Buffers

| Action                                                              | Mappings       |
| ------------------------------------------------------------------- | -------------- |
| Next Buffer                                                         | `]b`           |
| Previous Buffer                                                     | `[b`           |
| Switch Buffer                                                       | `Tab`          |
| Move Buffer Right                                                   | `>b`           |
| Move Buffer Left                                                    | `<b`           |
| Navigate to buffer tab with interactive picker                      | Leader + bb    |
| Close all buffers except the current                                | Leader + bc    |
| Close all buffers                                                   | Leader + bC    |
| Delete a buffer tab with interactive picker                         | Leader + bd    |
| Close all buffers to the left of the current                        | Leader + bl    |
| Go to the previous buffer                                           | Leader + bp    |
| Close all buffers to the right of the current                       | Leader + br    |
| Sort buffers by extension                                           | Leader + bse   |
| Sort buffers by buffer number                                       | Leader + bsi   |
| Sort buffers by last modification                                   | Leader + bsm   |
| Sort buffers by full path                                           | Leader + bsp   |
| Sort buffers by relative path                                       | Leader + bsr   |
| Open a buffer tab in a new horizontal split with interactive picker | `Leader + b\`  |
| Open a buffer tab in a new vertical split with interactive picker   | `Leader + b\|` |
| Next table                                                          | Leader + btn   |
| Previous table                                                      | Leader + btp   |
| First table                                                         | Leader + bth   |
| Last table                                                          | Leader + btl   |

### Commenting Mappings

| Action         | Mappings     |
| -------------- | ------------ |
| Toggle Comment | `Leader + /` |

### List Management

| Action                    | Mappings    |
| ------------------------- | ----------- |
| Open Quickfix List        | Leader + xq |
| Next Quickfix Entry       | ]q          |
| Previous Quickfix Entry   | [q          |
| Last Quickfix Entry       | ]Q          |
| First Quickfix Entry      | [Q          |
| Open Local List           | Leader + xl |
| Next Local List Entry     | ]l          |
| Previous Local List Entry | [l          |
| Last Local List Entry     | ]L          |
| First Local List Entry    | [L          |

### Better Escape

| Action     | Mappings |
| ---------- | -------- |
| Escape key | kj       |

### Neo-Tree

| Action         | Mappings   |
| -------------- | ---------- |
| Neotree toggle | Leader + e |
| Neotree focus  | Leader + o |

### Dashbaord Mappings

| Action           | Mappings   |
| ---------------- | ---------- |
| Dashboard (Home) | Leader + h |

### Session Manager Mappings

| Action                         | Mappings      |
| ------------------------------ | ------------- |
| Save Session                   | Leader + Ss   |
| Last Session                   | Leader + Sl   |
| Delete Session                 | Leader + Sd   |
| Delete Directory Session       | Leader + SD   |
| Search Sessions                | Leader + Sf   |
| Search Directory Sessions      | Leader + SF   |
| Load Current Directory Session | `Leader + S.` |

### LSP Mappings

| Action                   | Mappings         |
| ------------------------ | ---------------- |
| Hover Document           | K                |
| Format Document          | Leader + lf      |
| Symbols Outline          | Leader + lS      |
| Line Diagnostics         | gl, Leader + ld  |
| All Diagnostics          | Leader + lD      |
| Code Actions             | gra, Leader + la |
| Source Code Actions      | Leader + lA      |
| Signature Help           | gK, Leader + lh  |
| Rename                   | Leader + lr      |
| Document Symbols         | Leader + ls      |
| Workspace Symbols        | Leader + lG      |
| Diagnostic Next          | ]d               |
| Diagnostics Previous     | [d               |
| Document Symbol Next     | ]y               |
| Document Symbol Previous | [y               |
| Document Symbol          | gO               |
| Declaration              | gD               |
| Type Definition          | gy               |
| Definition               | gd               |
| Implementation           | gri              |
| References               | grr, Leader + lR |

> `<C-u>` and `<C-d>` can not scrolling the hover document, press `K` twice to put your cursor in the help window and then you can scroll

### Debugger Mappings

| Action                  | Mappings                 |
| ----------------------- | ------------------------ |
| Start/Continue Debugger | `Leader + dc or <F5>`    |
| Pause Debugger          | `Leader + dp or <F6>`    |
| Restart Debugger        | `Leader + dr or <C-F5>`  |
| Run Debugger to Cursor  | `Leader + ds`            |
| Close Debugger Session  | `Leader + dq`            |
| Terminate Debugger      | `Leader + dQ or <S-F5>`  |
| Toggle Breakpoint       | `Leader + db or <F9>`    |
| Conditional Breakpoint  | `Leader + dC or <S-F9>`  |
| Clear Breakpoints       | `Leader + dB`            |
| Step Over               | `Leader + do or <F10>`   |
| Step Into               | `Leader + di or <F11>`   |
| Step Out                | `Leader + dO or <S-F11>` |
| Evaluate Expression     | `Leader + dE`            |
| Toggle REPL             | `Leader + dR`            |
| Toggle Debugger UI      | `Leader + du`            |
| Debugger Hover          | `Leader + dh`            |

### Packer Mappings

| Action                                   | Mappings         |
| ---------------------------------------- | ---------------- |
| Marks                                    | `Leader + f'`    |
| Find Words in current buffer             | `Leader + f/`    |
| Resume previous search                   | `Leader + f<CR>` |
| Find ArstroNvim config files             | Leader + fa      |
| Buffers                                  | Leader + fb      |
| Word at cursor                           | Leader + fc      |
| Find word under cursor in current buffer | Leader + fC      |
| Find files                               | Leader + ff      |
| Find files (include hidden files)        | Leader + fF      |
| Help Tags                                | Leader + fh      |
| Keymaps                                  | Leader + fk      |
| Man Pages                                | Leader + fm      |
| Notifications                            | Leader + fn      |
| Old Files                                | Leader + fo      |
| Registers                                | Leader + fr      |
| Colorschemes                             | Leader + ft      |
| Live Grep                                | Leader + fw      |
| Live Grep (include hidden files)         | Leader + fW      |
| LSP Symbols                              | Leader + ls      |
| LSP Workspace Symbols                    | Leader + lG      |
| LSP References                           | Leader + lR      |
| LSP Diagnostics                          | Leader + lD      |
| Open TODOs in Telescope                  | Leader + fT      |
| Search Projects                          | Leader + fp      |
| Search GoImpl                            | Leader + fi      |

### Toggle Terminal Mappings

| Action                    | Mappings    | Status |
| ------------------------- | ----------- | ------ |
| Toggle Terminal           | F7          |        |
| Floating Terminal         | Leader + tf |        |
| Horizontal Split Terminal | Leader + th |        |
| Vertical Split Terminal   | Leader + tv |        |
| ipython                   | Leader + ti |        |

### Git Mappings

| Action                     | Mappings    |
| -------------------------- | ----------- |
| Next Hunk                  | `]g`        |
| Previous Hunk              | `[g`        |
| Git tracked files          | Leader + fg |
| Blame Line                 | Leader + gl |
| Preview Hunk               | Leader + gp |
| Reset Hunk                 | Leader + gr |
| Stage Hunk                 | Leader + gs |
| Stage Buffer               | Leader + gS |
| Unstage Hunk               | Leader + gu |
| Git Diff                   | Leader + gd |
| Git Branches               | Leader + gb |
| Git Commits (repository)   | Leader + gc |
| Git Commits (current file) | Leader + gC |
| Git browse (open)          | Leader + g  |
| Git Status                 | Leader + gt |
| Git Stash                  | Leader + gT |

### Telekasten

| Action                                                                 | Mappings           |
| ---------------------------------------------------------------------- | ------------------ |
| Find notes by title (filename)                                         | Leader + zf        |
| Search (grep) in all notes                                             | Leader + zg        |
| Rename current note                                                    | Leader + zr        |
| Open today's daily note                                                | Leader + zd        |
| Follow the link under the cursor                                       | Leader + zz        |
| Create a new note                                                      | Leader + zn        |
| Show the calendar                                                      | Leader + zc        |
| Show all notes linking to the current one                              | Leader + zb        |
| Brings up the tag list                                                 | Leader + zt        |
| Paste an image from the clipboard into a file and inserts a link to it | Leader + zi        |
| Browse images/media files and insert a link to the selected one        | Leader + zI        |
| Insert a link to a note                                                | `[[` (Insert mode) |

### Trouble

| Action                          | Mappings    |
| ------------------------------- | ----------- |
| Document Diagnostics (Trouble)  | Leader + xx |
| Workspace Diagnostics (Trouble) | Leader + xX |
| Location List (Trouble)         | Leader + xl |
| Quickfix List (Trouble)         | Leader + xq |
| TODOs (Trouble)                 | Leader + xT |

### Neogen

| Action              | Mappings    |
| ------------------- | ----------- |
| Autodocstring func  | Leader + nf |
| Autodocstring class | Leader + nc |

### Surroud

normal-mode: ys
insert-mode: `<C-g>s`
visual-mode: S
delete: ds
chagen: cs

### Easy move

1. `folke/flash.nvim`
2. move line `Alt +[j|k|h|l]`
3. `g*`, `g#`, Use `n` and `N` to navigate.

   - `*` searches forward for the word under the cursor
   - `#` searches backward for the word under the cursor

4. highlight the word under the cursor
   user `n` and `N` to navigate
   - search key: <Leader + s>
   - color key: <Leader + k>
5. hop `<Leader + jw>` support chinese characters

### Go Command

| Action                                | Command                                                  |
| ------------------------------------- | -------------------------------------------------------- |
| Add comments                          | GoCmt                                                    |
| Add Tags                              | GoAddTag                                                 |
| Remove Tags                           | GoRmTag                                                  |
| Run Tests                             | GoTest                                                   |
| Auto Fill Start                       | GoFillStruct                                             |
| Auto Fill Switch                      | GoFillSwitch                                             |
| Show go Docs                          | GoDoc eg: `GoDoc fmt.Println`                            |
| Generate impl                         | GoImpl eg: `GoImpl f *File io.Reader`,`GoImpl io.Reader` |
| run `go mod init` and restart gopls   | GoModInit                                                |
| run `go mod tidy` and restart gopls   | GoModTidy                                                |
| run `go mod vendor` and restart gopls | GoModVendor                                              |

[go.nvim](https://github.com/ray-x/go.nvim)

> Generate impl can use Telescope extension, keymap is `Leader + fi`

## LSP Install List

| Language   | LSP             | Debug    | Format                    |
| ---------- | --------------- | -------- | ------------------------- |
| python     | pyright         | debugpy  | isort,black,(`ruff_lsp`)  |
| go         | gopls           | delve    | goimports,gofumpt         |
| `c/c++`    | clangd          | cpptools | `clang_format`            |
| markdown   | markdown_oxide  |          | prettierd                 |
| sh         | shfmt           |          |                           |
| json       | jq,`jsonld_lsp` |          | prettierd                 |
| cmake      | cmake,          |          | cmakelang(`cmake_format`) |
| yaml       | yamlls          |          | prettierd                 |
| lua        | `lua_ls`        |          | stylua                    |
| Dockerfile | dockerls        |          |                           |

## Snippets

```bash
[friendly-snippets](https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua)
[LuaSnip](https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua)
```

custom snippets

- [Neovim setting up snippets with luasnip](https://sbulav.github.io/vim/neovim-setting-up-luasnip/)
- [LuaSnip Docs](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md)

## Alt Mappings

Use `A` or `M`, like `<A-t>` ,`<M-up>`

## Execute nvim command in terminal

```bash
nvim --headless +PluginInstall +qa
```

## Convert filetype

Convert dos to unix or the line endswith `^M`

```bash
apt-get install dos2unix

dos2unix filename
```

## Swith tab and space

> at vim command mode

1.  tab to 4 spaces

    ```
    :set ts=4
    :set expandtab
    :%retab!
    ```

2.  4 spaces to tab

    ```
    :set ts=4
    :set noexpandtab
    :%retab!
    ```

### Rime

1. `;f` 启动中文输入法
2. `;;` 停止输入法
3. `;j` 退出插入模式
4. `;u` undo
