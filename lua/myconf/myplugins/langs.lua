return {
	run={
		interpreted= {
			javascript="if [ -f package.json && _snippet -ne 1 ]; then npm i && npm run; else node _file; fi",
			lua="lua _file",
			php="[[ $(head -n1 _file) == \"<?php\" ]] && php _file || echo -e \"<?php\\n$(cat _file)\" | php",
			sh="bash _file",
			python="[[ -f main.py && _snippet -ne 1 ]] && python main.py || python _file",
		},
		compiled= {
			pascal="fpc _file && if [ -f _filename ]; then _filename; rm _filename.o; rm _filename; fi",
            c="gcc _file -o _filename -lm && _filename; [ -f _filename ] && rm _filename;",
			rust="if [ -f Cargo.toml ]; then cargo run; else rustc _file && _filename; [ -f _filename ] && rm _filename; fi"
		}
	},
	test={
		interpreted= {},
		compiled= {
			pascal="[ -f _filename.test ] && pas-test _file || echo 'Test no specified'",
			rust="[ -f Cargo.toml ] && cargo test';"
		}
	}
}
