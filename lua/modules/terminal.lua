return {{'voldikss/vim-floaterm',
	config = function()
		keymapper('n', '<F12>', '<cmd>FloatermToggle<CR>', {noremap=true})
		keymapper('t', '<F12>', '<cmd>FloatermToggle<CR>', {noremap=true})
		keymapper('t', '<C-Down>', '<cmd>FloatermNext<CR>', {noremap=true})
		keymapper('t', '<C-Up>', '<cmd>FloatermPrev<CR>', {noremap=true})
		keymapper('t', '<C-n>', '<cmd>FloatermNew<CR>', {noremap=true})
	end
}}