# Neovim Keybindings

Leader key: `,`

## Leader (`,`) — General

| Key | Mode | Action |
|---|---|---|
| `,p` | n | Paste below |
| `,P` | n | Paste above |
| `,w` | n | Save buffer |
| `,q` | n | Save & quit window |
| `,Q` | n | Quit all |
| `,bc` | n | Close buffer |
| `,ev` | n | Open init.lua |
| `,sv` | n | Reload init.lua |
| `,v` | n | Reselect last pasted text |
| `,cd` | n | Change cwd to file's dir |
| `,H` | n | Open dashboard (alpha) |
| `,<space>` | n | Strip trailing whitespace |
| `,y` | n | Yank whole buffer |
| `,cl` | n | Toggle cursor column |
| `,cb` | n | Blink cursor |
| `,a` | n | Toggle Supermaven |
| `,K` | n | Preview folded lines (UFO) |
| `,t` | n | Toggle terminal |

## Leader (`,`) — Files / Search (fzf-lua)

| Key | Mode | Action |
|---|---|---|
| `,ff` | n | Find files |
| `,fg` | n | Live grep |
| `,fh` | n | Help tags |
| `,ft` | n | Buffer tags |
| `,fb` | n | Buffers |
| `,fr` | n | Recent files |

## Leader (`,`) — Git

| Key | Mode | Action |
|---|---|---|
| `,gs` | n | Git status |
| `,gw` | n | Git add (write) |
| `,gc` | n | Git commit |
| `,gpl` | n | Git pull |
| `,gpu` | n | Git push |
| `,gb` | v | Git blame selection |
| `,gbn` | n | New branch |
| `,gf` | n | Git fetch (prune) |
| `,gbd` | n | Delete branch |
| `,gl` | n, v | Copy permalink |
| `,gbr` | n | Browse repo |
| `]c` / `[c` | n | Next / previous hunk |
| `,hp` | n | Preview hunk |
| `,hb` | n | Blame hunk |

## Leader (`,`) — Rust

| Key | Mode | Action |
|---|---|---|
| `,rr` | n | Run Rust code |
| `,rt` | n | Run Rust tests |

## Leader (`,`) — OpenCode

| Key | Mode | Action |
|---|---|---|
| `,oa` | n, x | Ask opencode |
| `,ox` | n, x | Execute opencode action |
| `,ot` | n, t | Toggle opencode |
| `,os` | n, v | Sync buffer/selection to OpenCode |
| `go` | n, x | Add range to opencode (operator) |
| `goo` | n | Add line to opencode |

## Space (`<space>`) — LSP

| Key | Mode | Action |
|---|---|---|
| `<space>rn` | n | LSP rename |
| `<space>ca` | n | LSP code action |
| `<space>wa` | n | Add workspace folder |
| `<space>wr` | n | Remove workspace folder |
| `<space>wl` | n | List workspace folders |
| `<space>gd` | n | Definitions (glance) |
| `<space>gr` | n | References (glance) |
| `<space>gi` | n | Implementations (glance) |

## Space (`<space>`) — Files / Diagnostics

| Key | Mode | Action |
|---|---|---|
| `<space>s` | n | Toggle nvim-tree explorer |
| `<space>bp` | n | Pick buffer (bufferline) |
| `<space>qw` | n | Window diagnostics → quickfix |
| `<space>qb` | n | Buffer diagnostics → quickfix |
| `<space>f` | n | Format file (by filetype: JSONFormat / black / stylua) |

## F9 — Filetype runners

| Key | Filetype | Action |
|---|---|---|
| `F9` | cpp | Compile & run |
| `F9` | lua | Source current file |
| `F9` | python | Run `python -u %` |
| `F9` | vim | Source current file |
| `F9` | tex | Compile (vimtex) |

## Normal mode

| Key | Mode | Action |
|---|---|---|
| `;` | n, x | Command mode |
| `j` / `k` | n | Physical-line move |
| `^` / `0` | n | Wrapped line start |
| `H` / `L` | n, x | Line start / end |
| `<A-k>` / `<A-j>` | n | Move line up / down |
| `<A-l>` / `<A-h>` | n | Next / previous tab |
| `c` / `C` / `cc` | n | Change into blackhole register |
| `J` / `gJ` | n | Join lines, keep cursor |
| `gb` / `gB` | n | Next / previous buffer |
| `\x` | n | Close quickfix + location list |
| `\d` | n | Delete buffer (keep window) |
| `\D` | n | Delete other buffers |
| `/` | n | Search (very-magic) |
| `<F11>` | n | Toggle spell |
| Arrows | n | Move window |
| `<Esc>` | n | Close floating window |
| `gd` / `<C-]>` | n | Go to definition |
| `K` | n | Hover |
| `<C-k>` | n | Signature help |
| `f` | n, v, o | Hop jump to char |
| `n` / `N` | n | Next / previous match (hlslens) |
| `*` / `#` | n | Search word forward / backward (hlslens) |
| `zR` / `zM` / `zr` | n | Open all / close all / open folds |
| `gc` | n, v | Toggle comment |
| `ga` | n | Unicode info |

## Visual mode

| Key | Action |
|---|---|
| `$` | Exclude trailing whitespace |
| `<` / `>` | Shift selection, stay selected |
| `c` | Change into blackhole register |
| `<A-k>` / `<A-j>` | Move selection up / down |
| `p` | Paste without contaminating register |

## Insert mode

| Key | Action |
|---|---|
| `<c-u>` | Uppercase word |
| `<c-t>` | Title-case word |
| `, . ! ? ; :` | Break undo unit |
| `<A-;>` | Insert `;` at end of line |
| `<C-A>` | Go to line start |
| `<C-E>` | Go to line end |
| `<C-D>` | Delete char to the right |

## Completion (blink-cmp)

| Key | Action |
|---|---|
| `<Tab>` / `<S-Tab>` | Select next / previous |
| `<Enter>` | Select & accept |
| `<C-l>` | Snippet forward |
| `<C-h>` | Snippet backward |
| `<C-b>` / `<C-f>` | Scroll docs up / down |

## Supermaven

| Key | Action |
|---|---|
| `<C-e>` | Accept suggestion |
| `<C-]>` | Clear suggestion |
| `<C-j>` | Accept word |

## Terminal mode

| Key | Action |
|---|---|
| `<Esc>` | Exit to normal mode |

## Yank / Put (yanky)

| Key | Mode | Action |
|---|---|---|
| `p` / `P` | n, x | Put after / before |
| `[y` / `]y` | n | Previous / next yank history |

## Text objects

| Key | Mode | Action |
|---|---|---|
| `iu` | x, o | URL |
| `iB` | x, o | Whole buffer |
| `ic` / `ac` | x, o | Markdown code block |
| `if` / `af` | x, o | Function (treesitter) |
| `ic` / `ac` | x, o | Class (treesitter) |
| `^^` | n, i | Insert markdown footnote |
| `@@` | i, n | Return from footnote |
| `+` | n, x | Add list marker |
| `\` | n, x | Add hard line break |

## Dashboard (alpha, buffer-local)

| Key | Action |
|---|---|
| `f` | Find files |
| `r` | Recent files |
| `g` | Live grep |
| `c` | Edit init.lua |
| `m` | Edit mappings.lua |
| `b` | List buffers |
| `n` | Edit niri config |
| `t` | Apply vague colorscheme |
| `q` | Quit |

## Disabled keys

| Key | Note |
|---|---|
| `s` | Remapped to `<Nop>` (vim-sandwich) — use `cl` instead |