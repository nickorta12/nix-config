{keymap, ...}: let
  inherit (keymap) nmap imap tmap nlua;
in {
  keymaps = [
    (nmap "<leader>bn" ":BufferNext<cr>" "Next Buffer")
    (nmap "<leader>bp" ":BufferPrevious<cr>" "Previous Buffer")
    (nmap "<leader>bd" ":BufferClose<cr>" "Close Buffer")
    (nmap "<leader>bD" ":BufferCloseAllButCurrent<cr>" "Close all Other Buffers")
    (nmap "<leader>bk" ":BufferPick<cr>" "Pick Buffer")
    (nmap "<leader>bK" ":BufferPickDelete<cr>" "Pick Buffer Delete")
    (nmap "<leader>bl" ":Neotree buffers<cr>" "List Buffers")
    (nmap "<A-,>" ":BufferNext<cr>" "Next Buffer")
    (nmap "<A-.>" ":BufferPrevious<cr>" "Previous Buffer")

    (nmap "<leader>tn" ":tabn<cr>" "Next Tab")
    (nmap "<leader>tp" ":tabp<cr>" "Previous Tab")

    (nmap "<C-d>" "<C-d>zz" "Scroll Down")
    (nmap "<C-u>" "<C-u>zz" "Scroll Up")

    (nmap "<leader>e" ":Neotree<cr>" "Show Explorer")
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

    (nlua "<leader>f" "require('conform').format()" "Format buffer")

    (nmap "<leader>;" "mmA;<esc>`m" "Add semicolon")
    (imap "<C-g>;" "<esc>mmA;<esc>`ma" "Add semicolon")
    (nmap "<leader>," "mmA,<esc>`m" "Add comma")
    (nmap "<C-g>," "<esc>mmA,<esc>`ma" "Add comma")

    (tmap "<esc><esc>" "<C-\\><C-n>" "Exit Terminal")
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
        ];
      };
    };
  };
}
