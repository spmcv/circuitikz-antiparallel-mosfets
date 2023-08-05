tex:
	latexmk example

svg:
	dvisvgm example

clean:
	latexmk -c 

clean-all:
	latexmk -C
	rm *.svg
