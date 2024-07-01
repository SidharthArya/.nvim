return {{'nanotee/zoxide.vim',
	config = function()
		keymapper('n', '<Space>pp', ':Z ', {noremap=true})
	end
},
{'ahmedkhalf/project.nvim',
	config = function()
	require("project_nvim").setup {
    	}
	end
}
}