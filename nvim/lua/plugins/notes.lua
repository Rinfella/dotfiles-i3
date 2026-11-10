-- lua/plugins/notes.lua
return {
    -- Obsidian
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        lazy = true,
        cmd = "Obsidian",
        ft = "markdown",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            workspaces = {
                {
                    name = "notes",
                    path = vim.fn.expand("~/Documents/obsidian-notes"),
                },
            },
            ui = { enable = false },
            daily_notes = {
                folder = "notes/daily-notes",
                date_format = "%Y-%m-%d",
                template = "daily_notes.md",
            },
            templates = {
                folder = "templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
                substitutions = {},
            },
            completion = { nvim_cmp = true },
            legacy_commands = false,
            note_id_func = function(title)
                local suffix = ""
                if title ~= nil then
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.date("%Y%m%d")) .. "-" .. suffix
            end,
            attachments = {
                folder = "assets/imgs",
            },
            picker = {
                name = "telescope.nvim",
            },
        },
    },

    -- Render Markdown
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        opts = {},
    },

    -- Cheatsheet
    {
        "doctorfree/cheatsheet.nvim",
        cmd = "Cheatsheet",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    },

    -- Auto Session
    {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup({
                suppress_dirs = { "~/", "~/projects", "~/Downloads", "/" },
            })
        end,
    }
}
