-- lua/config/keymaps.lua
local map = vim.keymap.set

-- === Core ===
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Highlight" })

-- === Navigation ===
map("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- === Editor Tools ===
map("n", "<leader>e", "<cmd>Neotree reveal<cr>", { desc = "Explorer Reveal" })
map("n", "<leader>o", "<cmd>Neotree toggle<cr>", { desc = "Explorer Toggle" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })

-- Git
map("n", "<leader>gg", "<cmd>Lazygit<cr>", { desc = "Lazygit" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame Line" })

-- Trouble (Diagnostics)
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
map("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false<cr>", { desc = "LSP (Trouble)" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })

-- === 99 (AI Agent) ===
map("n", "<leader>9v", function() require("99").visual() end, { desc = "99: Visual Selection" })
map("n", "<leader>9V", function() require("99").visual({ prompt = true }) end, { desc = "99: Visual (Prompt)" })
map("n", "<leader>9s", function() require("99").stop_all_requests() end, { desc = "99: Stop Requests" })
map("n", "<leader>9l", function() require("99").view_logs() end, { desc = "99: View Logs" })
map("n", "<leader>9i", function() require("99").info() end, { desc = "99: Info" })

-- === Notes (Grouped under <leader>n) ===
-- Navigation
map("n", "<leader>nn", "<cmd>Obsidian new<cr>",           { desc = "Obsidian: New Note" })
map("n", "<leader>nf", "<cmd>Obsidian search<cr>",        { desc = "Obsidian: Find Note" })
map("n", "<leader>nq", "<cmd>Obsidian quick_switch<cr>",  { desc = "Obsidian: Quick Switch" })
map("n", "<leader>ng", "<cmd>Obsidian tags<cr>",          { desc = "Obsidian: Search Tags" })

-- Daily Notes
map("n", "<leader>nd", "<cmd>Obsidian today<cr>",         { desc = "Obsidian: Daily Note" })
map("n", "<leader>ny", "<cmd>Obsidian yesterday<cr>",     { desc = "Obsidian: Yesterday" })
map("n", "<leader>nm", "<cmd>Obsidian tomorrow<cr>",      { desc = "Obsidian: Tomorrow" })

-- Templates & Creation
map("n", "<leader>nt", "<cmd>Obsidian template<cr>",      { desc = "Obsidian: Insert Template" })
map("n", "<leader>ni", "<cmd>Obsidian new_from_template<cr>", { desc = "Obsidian: New from Template" })
map("v", "<leader>nx", "<cmd>ObsidianExtractNote<cr>",    { desc = "Obsidian: Extract Selection → Note" })
map("n", "<leader>ns", "<cmd>Obsidian new<cr>",           { desc = "Obsidian: New Scratch/Inbox" })

-- Links & Graph
map("n", "<leader>nb", "<cmd>Obsidian backlinks<cr>",     { desc = "Obsidian: Backlinks" })
map("n", "<leader>nl", "<cmd>Obsidian links<cr>",         { desc = "Obsidian: Outgoing Links" })
map("n", "<leader>nL", "<cmd>Obsidian link_new<cr>",      { desc = "Obsidian: Link to New Note" })
map("v", "<leader>nk", "<cmd>Obsidian link<cr>",          { desc = "Obsidian: Link Selection" })

-- Rename / workspace
map("n", "<leader>nr", "<cmd>Obsidian rename<cr>",        { desc = "Obsidian: Rename Note" })
map("n", "<leader>nw", "<cmd>Obsidian workspace<cr>",     { desc = "Obsidian: Switch Workspace" })

-- Clipboard / Neoclip (moved off <leader>nc to avoid collision)
map("n", "<leader>ch", "<cmd>Telescope neoclip initial_mode=normal<cr>", { desc = "Clipboard History (Neoclip)" })

-- === Terminal ===
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Term Horizontal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Term Float" })

-- === Smart gf for Obsidian ===
map("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<cr>"
    else
        return "gf"
    end
end, { noremap = false, expr = true, desc = "Follow Obsidian Link" })

