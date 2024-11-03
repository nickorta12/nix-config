{keymap, ...}: let
  kn = keymap.mkKey "n";
  gn = key: group: kn key group group;
in {
  keymaps = [
    (gn "<leader>s" "+search")
    (gn "<leader>b" "+buffers")

    (kn "<leader>bn" "<cmd>bn<cr>" "Next Buffer")
    (kn "<leader>bp" "<cmd>bp<cr>" "Previous Buffer")
    (kn "<leader>bd" "<cmd>bd<cr>" "Close Buffer")
    (kn "<leader>bD" "<cmd>bd!<cr>" "Force Close Buffer")
    (kn "<leader>bl" "<cmd>ls<cr>" "List Buffers")

    (kn "<C-d>" "<C-d>zz" "Scroll Down")
    (kn "<C-u>" "<C-u>zz" "Scroll Up")
  ];
}
