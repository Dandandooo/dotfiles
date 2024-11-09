{ config, ... }:

{
    programs.nixvim.globals = {
        mapleader = " ";
    };
    
    programs.nixvim.keymaps = [
        ### NeoTree
        { mode = "n"; key = "<leader>nt"; action = "<cmd>Neotree toggle<cr>"; }
        { mode = "n"; key = "<leader>nf"; action = "<cmd>Neotree focus<cr>"; }
        { mode = "n"; key = "<leader>ns"; action = "<cmd>Neotree position=current toggle<cr>"; }

        ### Telescope
        { mode = "n"; key = "<leader>fs"; action = "<cmd>Telescope<cr>"; }
        { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; }
        { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; }
        { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>"; }
        { mode = "n"; key = "<leader>fh"; action = "<cmd>Telescope help_tags<cr>"; }
        { mode = "n"; key = "<leader>fr"; action = "<cmd>Telescope git_files<cr>"; }
        { mode = "n"; key = "<leader>fc"; action = "<cmd>Telescope commands<cr>"; }
        { mode = "n"; key = "<leader>ft"; action = "<cmd>Telescope colorscheme<cr>"; }

        ### Gitsigns
        { mode = "n"; key = "<leader>gb"; action = "<cmd>Gitsigns toggle_current_line_blame<cr>"; }
        { mode = "n"; key = "<leader>gp"; action = "<cmd>Gitsigns preview_hunk<cr>"; }
        { mode = "n"; key = "<leader>gh"; action = "<cmd>Gitsigns toggle_linehl<cr>"; }
        { mode = "n"; key = "<leader>gs"; action = "<cmd>Gitsigns toggle_signs<cr>"; }
        
        ### 

    ];
}
