{keymap, ...}: let
  kmap = keymap.mkKey "n";
  imap = keymap.mkKey "i";
  tmap = keymap.mkKey "t";
in {
  keymaps = [
    (kmap "<leader>bn" "<cmd>bn<cr>" "Next Buffer")
    (kmap "<leader>bp" "<cmd>bp<cr>" "Previous Buffer")
    (kmap "<leader>bd" "<cmd>bd<cr>" "Close Buffer")
    (kmap "<leader>bD" "<cmd>bd!<cr>" "Force Close Buffer")
    (kmap "<leader>bl" "<cmd>ls<cr>" "List Buffers")

    (kmap "<C-d>" "<C-d>zz" "Scroll Down")
    (kmap "<C-u>" "<C-u>zz" "Scroll Up")

    (kmap "<leader>y" "<cmd>Yazi<cr>" "Open File Browser (Yazi)")

    (kmap "<leader>;" "mmA;<esc>`m" "Add semicolon")
    (imap "<C-g>;" "<esc>mmA;<esc>`ma" "Add semicolon")
    (kmap "<leader>," "mmA,<esc>`m" "Add comma")
    (kmap "<C-g>," "<esc>mmA,<esc>`ma" "Add comma")

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
