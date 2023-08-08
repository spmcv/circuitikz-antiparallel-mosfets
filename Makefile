all: tex svg

tex:
	latexmk example

svg:
	dvisvgm example

clean:
	latexmk -c 

distclean:
	latexmk -C
	rm *.svg
