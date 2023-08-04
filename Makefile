example:
	latexmk example

vector:
	dvisvgm example

clean:
	latexmk -c 

clean-all:
	latexmk -C
	rm *.svg
