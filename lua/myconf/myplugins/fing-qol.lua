
return {
	{
		name="ArreglarFormatoDeLosPracticosYElLatexDeLosCojone",
		callback=function()
			vim.cmd [[call append(line('.')-1, '---')]]
			vim.cmd [[call append(line('.')+2, '---')]]
			vim.cmd [[%s:^p´ag. [1-9] de [1-5]:]]
			vim.cmd [[%s:´a:á:g | %s:´e:é:g | %s:´ı:í:g | %s:´o:ó:g | %s:´u:ú:g | %s:˜n:ñ:g]]
		end,
		args={ nargs = '*', desc = 'Run the whole file' }
	}
}
