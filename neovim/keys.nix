{keymap, ...}: let
  inherit (keymap) nmap imap tmap nlua;
in {
  keymaps = [
    (nmap "<leader>bn" "<cmd>bn<cr>" "Next Buffer")
    (nmap "<leader>bp" "<cmd>bp<cr>" "Previous Buffer")
    (nmap "<leader>bd" "<cmd>bd<cr>" "Close Buffer")
    (nmap "<leader>bD" "<cmd>bd!<cr>" "Force Close Buffer")
    (nmap "<leader>bl" "<cmd>ls<cr>" "List Buffers")

    (nmap "<C-d>" "<C-d>zz" "Scroll Down")
    (nmap "<C-u>" "<C-u>zz" "Scroll Up")

    (nmap "<leader>y" "<cmd>Yazi<cr>" "Open File Browser (Yazi)")

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
        ];
      };
    };
  };
}
