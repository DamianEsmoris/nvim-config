
return {
	{
		name="ArreglarFormatoDeLosPracticosYElLatexDeLosCojone",
		callback=function()
			vim.cmd [[
                silent! %s:´a:á:g
                silent! %s:´e:é:g
                silent! %s:´ı:í:g
                silent! %s:´o:ó:g
                silent! %s:´u:ú:g
                silent! %s:˜n:ñ:g
            ]]
		end,
		args={ nargs = '*', desc = 'Fix latex tildes' }
	}
}
