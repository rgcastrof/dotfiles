require("lualine").setup {
	options = {
		icons_enabled = false,
		theme = "auto",
		section_separators = "", component_separators = "",
	},

	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {"mode", "filename", "branch", "diff"},
		lualine_x = {
			{
                "diagnostics",
                sections = { "error", "warn", "info", "hint" },
                -- diagnostics_color = {
					-- error = "DiagnosticError",
					-- warn  = "DiagnosticWarn",
					-- info  = "DiagnosticInfo",
					-- hint  = "DiagnosticHint",
                -- },
				symbols = {error = "● ", warn = "● ", info = "● ", hint = "● "},
			},
			"encoding", "fileformat", "%y", "%l:%c"
		},
		lualine_y = {},
		lualine_z = {}
	},
}
