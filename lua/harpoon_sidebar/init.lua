--- Public API for harpoon-sidebar.nvim
---
--- This module is what users should require and configure:
---   require("harpoon_sidebar").setup({ ... })
---
--- All breaking changes to function signatures here should bump
--- the major version of this plugin.

local M = {
    opts = {
        -- Whether to set up a default keymap for Neotree integration.
        default_mappings = true,

        -- Default mapping to toggle Neo-tree + sidebar.
        toggle_mapping = "<leader>e",

        -- Whether to enable neo-tree integration at all.
        enable_neotree = true,
    },
}

local function apply_default_mappings()
    if not M.opts.default_mappings then
        return
    end

    -- Mapping to toggle Neo-tree plus Harpoon sidebar.
    vim.keymap.set("n", M.opts.toggle_mapping, function()
        require("harpoon_sidebar.neotree").toggle()
    end, { desc = "Neo-tree + Harpoon sidebar" })
end

function M.setup(opts)
    M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})

    -- Load sidebar functionality (always available)
    require("harpoon_sidebar.sidebar")

    -- Load neo-tree integration (optional but enabled by default)
    if M.opts.enable_neotree then
        require("harpoon_sidebar.neotree")
    end

    apply_default_mappings()
end

-- Allow direct calls like: require("harpoon_sidebar").open()
function M.open()
    require("harpoon_sidebar.sidebar").open()
end

return M
