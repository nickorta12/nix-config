{keymap, ...}: let
  inherit (keymap) nmap imap tmap nlua;
in {
  keymaps = [
    (nmap "<leader>bn" ":bn<cr>" "Next Buffer")
    (nmap "<leader>bp" ":bp<cr>" "Previous Buffer")
    (nmap "<A-,>" ":bn<cr>" "Next Buffer")
    (nmap "<A-.>" ":bp<cr>" "Previous Buffer")
    (nmap "<leader>bd" ":Bdelete<cr>" "Close Buffer")
    (nmap "<leader>bw" ":Bwipeout<cr>" "Wipeout Buffers")
    (nmap "<leader>bD" ":%bd|e#<cr>" "Close all Other Buffers")
    (nmap "<leader>bk" ":BufferLinePick<cr>" "Pick Buffer")
    (nmap "<leader>bK" ":BufferLinePickClose<cr>" "Pick Buffer Delete")
    (nmap "<leader>bl" ":Neotree buffers<cr>" "List Buffers")

    (nmap "<leader>tn" ":tabn<cr>" "Next Tab")
    (nmap "<leader>tp" ":tabp<cr>" "Previous Tab")
    (nmap "<leader>td" ":tabclose<cr>" "Close Tab")
    (nmap "<leader>tc" ":tabnew<cr>" "New Tab")

    (nmap "<C-d>" "<C-d>zz" "Scroll Down")
    (nmap "<C-u>" "<C-u>zz" "Scroll Up")

    (nmap "<leader>e" ":Neotree<cr>" "Show Explorer")
    (nmap "<leader>E" ":Neotree toggle<cr>" "Toggle Explorer")
    (nmap "<leader>u" ":UndotreeToggle<cr>" "Toggle UndoTree")
    (nmap "<leader>y" ":Yazi<cr>" "Open File Browser (Yazi)")

    (nmap "<leader>gg" ":LazyGit<CR>" "Open LazyGit")
    (nmap "<leader>gb" ":Git blame<CR>" "Git Blame")
    (nmap "<leader>gs" ":Git status<CR>" "Git Status")
    (nmap "<leader>gd" ":Gitsigns diffthis<CR>" "Git Diff")

    (nmap "<leader>wk" "<C-w>k" "Window Up")
    (nmap "<leader>wj" "<C-w>j" "Window Down")
    (nmap "<leader>wh" "<C-w>h" "Window Left")
    (nmap "<leader>wl" "<C-w>l" "Window Right")
    (nmap "<leader>wp" "<C-w>p" "Window Previous")
    (nmap "<leader>ww" "<C-w>w" "Window Down/Right")
    (nmap "<leader>wW" "<C-w>W" "Window Up/Left")
    (nmap "<leader>wt" "<C-w>t" "Window Top-Left")
    (nmap "<leader>wb" "<C-w>b" "Window Bottom-Right")
    (nmap "<leader>wq" "<C-w>q" "Window Delete")

    (nmap "<leader>xx" ":Trouble diagnostics toggle<cr>" "Diagnostics")
    (nmap "<leader>xX" ":Trouble diagnostics toggle filter.buf=0<cr>" "Buffer Diagnostics")
    (nmap "<leader>xs" ":Trouble symbols toggle focus=false<cr>" "Symbols")
    (nmap "<leader>xl" ":Trouble lsp toggle focus=false win.position=right<cr>" "LSP Definitions / References")
    (nmap "<leader>xL" ":Trouble loclist toggle<cr>" "Location List")
    (nmap "<leader>xQ" ":Trouble qflist toggle<cr>" "Quickfix List")

    (nlua "<leader>f" "require('conform').format()" "Format buffer")

    (nmap "<leader>rw" "yiw:s/<C-r>\"/" "Replace word in line")
    (nmap "<leader>rW" "yiw:%s/<C-r>\"/" "Replace word in file")

    (nmap "<leader>;" "mmA;<esc>`m" "Add semicolon")
    (imap "<C-g>;" "<esc>mmA;<esc>`ma" "Add semicolon")
    (nmap "<leader>," "mmA,<esc>`m" "Add comma")
    (nmap "<C-g>," "<esc>mmA,<esc>`ma" "Add comma")

    # (tmap "<esc><esc>" "<C-\\><C-n>" "Exit Terminal")
  ];
  plugins = {
    which-key = {
      enable = true;
      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>b";
            group = "Buffers";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "Search";
          }
          {
            __unkeyed-1 = "<leader>h";
            group = "GitGutter";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "Git";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "Window";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "Tab";
          }
          {
            __unkeyed-1 = "<leader>x";
            group = "Diagnostics";
          }
          {
            __unkeyed-1 = "<leader>v";
            group = "LSP";
          }
        ];
      };
    };
  };
}
