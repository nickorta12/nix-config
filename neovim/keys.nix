{keymap, ...}: let
  inherit (keymap) nmap imap tmap nlua;
in {
  keymaps = [
    (nmap "<leader>bn" ":bn<cr>" "Next Buffer")
    (nmap "<leader>bp" ":bp<cr>" "Previous Buffer")
    (nmap "<leader>bd" ":bd<cr>" "Close Buffer")
    (nmap "<leader>bD" ":bd!<cr>" "Force Close Buffer")
    (nmap "<leader>bO" ":BufferCloseAllButCurrent<cr>" "Close all Other Buffers")
    (nmap "<leader>bk" ":BufferPick<cr>" "Pick Buffer")
    (nmap "<leader>bK" ":BufferPickDelete<cr>" "Pick Buffer Delete")
    (nmap "<leader>bl" ":ls<cr>" "List Buffers")

    (nmap "<C-d>" "<C-d>zz" "Scroll Down")
    (nmap "<C-u>" "<C-u>zz" "Scroll Up")

    (nmap "<leader>u" ":UndotreeToggle<cr>" "Toggle UndoTree")
    (nmap "<leader>y" ":Yazi<cr>" "Open File Browser (Yazi)")

    (nmap "<leader>gg" ":LazyGit<CR>" "Open LazyGit")
    (nmap "<leader>gb" ":Git blame<CR>" "Git Blame")
    (nmap "<leader>gs" ":Git status<CR>" "Git Status")
    (nmap "<leader>gd" ":Gitsigns diffthis<CR>" "Git Diff")

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
        ];
      };
    };
  };
}
