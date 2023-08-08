tex:
	latexmk example.tex

svg:
	dvisvgm example.xdv

clean:
	latexmk -c 

clean-all:
	latexmk -C
	rm *.svg
