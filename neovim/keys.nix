{keymap}: let
  kn = keymap.mkKey "n";
in {
  keymaps = [
    (kn "<leader>bn" "<cmd>bn<cr>" "Next Buffer")
    (kn "<leader>bp" "<cmd>bp<cr>" "Previous Buffer")
    (kn "<leader>bd" "<cmd>bd<cr>" "Close Buffer")
    (kn "<leader>bD" "<cmd>bd!<cr>" "Force Close Buffer")
    (kn "<leader>bl" "<cmd>ls<cr>" "List Buffers")
  ];
};
