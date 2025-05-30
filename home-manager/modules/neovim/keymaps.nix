{ config, ... }: let
    harpoons = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
in {
    programs.nixvim.globals = {
        mapleader = " ";
    };
    
    programs.nixvim.keymaps = [
        ### NeoTree & Yazi
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
        
        ### Whichkey
        { mode = "n"; key = "<leader>?"; action = "<cmd>Whichkey<cr>"; }

        ### Harpoon
        { mode = "n"; key = "<leader>ha"; action.__raw = "function() require'harpoon':list():add() end"; }
        { mode = "n"; key = "<leader>hs"; action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end"; }
    ] ++
    (map (n: 
        ### Harpoon Tab Selection
        { mode = "n"; key = "<C-${n}>"; action.__raw = "function() require'harpoon':list():select(${n}) end"; }
    ) [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ]);
}
