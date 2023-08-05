# CircuiTikz: Antiparallel MOSFETs

![image info](example.svg "SVG output")

Example of a CircuiTikz subcircuit demonstrating antiparallel MOSFETs and a current sense resistor.

## Description

This tutorial demonstrates using the CircuiTikz package of LaTeX to create
reusable circuits intended to be incorporated as part of a larger document 
(for example, a paper, poster, or system diagram) or as a standalone vector
graphics asset for use in other documentation formats.

## Implementation

After considering various options, the most straightforward approach seemed
to be to use `latexmk` to generate `DVI->PDF` and `DVI->SVG` using a Makefile.
For ease of use, I limited the software tools I used to those included in a standard TeXLive distribution.

## Challenges

It's technically possible to use the `standalone` LaTeX package to export
bitmap and vector graphics with the `convert` configuration option. Martin
Scharrer, the author of `standalone`, elaborates on that point in a Stack
Exchange [answer](https://tex.stackexchange.com/a/51766). However, I had a
lot of difficulty getting this method to operate as intended with `latexmk`.

### Shell Escape
At first, the conversion failed to execute without the latexmk `-shell-escape`
option. Note that `latexmkrc` file would need entries like:

```
$latex = 'latex -shell-escape';
```

as a required option each interpreter(`latex`, `pdflatex`, etc.)

### GhostScript

After that, the conversion failed due to [dvisvgm](https://dvisvgm.de) being
unable to locate the GhostScript dynamic library path. This may be a primarily
macOS and Homebrew [issue](https://tex.stackexchange.com/a/559650). With:

```
export LIBGS=/opt/homebrew/Cellar/ghostscript/[version]/lib/libgs.dylib
```

the `dvisvgm` generated the expected output with the Makefile. However,
as alluded to before with the `-shell-escape'` option, the dynamic library
path would need to be fixed globally for `latexmk` to spawn another shell
execute the `convert` configuration option.  

## Usage

The included Makefile contains all commands to render the graphics assets.
Use `make tex` to generate the PDF output and `make svg` to generate the SVG
output. Note that the later command is dependent on the former.