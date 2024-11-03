{keymap, ...}: let
  kn = keymap.mkKey "n";
in {
  keymaps = [
    (kn "<leader>bn" "<cmd>bn<cr>" "Next Buffer")
    (kn "<leader>bp" "<cmd>bp<cr>" "Previous Buffer")
    (kn "<leader>bd" "<cmd>bd<cr>" "Close Buffer")
    (kn "<leader>bD" "<cmd>bd!<cr>" "Force Close Buffer")
    (kn "<leader>bl" "<cmd>ls<cr>" "List Buffers")

    (kn "<C-d>" "<C-d>zz" "Scroll Down")
    (kn "<C-u>" "<C-u>zz" "Scroll Up")

    (kn "<leader>y" "<cmd>Yazi<cr>" "Open File Browser (Yazi)")
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
