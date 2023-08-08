# CircuiTikz: Antiparallel MOSFETs

![image info](example.svg "SVG output")

Example of a CircuiTikz subcircuit demonstrating antiparallel MOSFETs and a current sense resistor.

## Description

This tutorial demonstrates utilizing the CircuiTikz package of LaTeX to create
reusable circuits intended to be incorporated as part of a larger document 
(for example, a paper, poster, or system diagram) or as a standalone vector
graphics asset for use in other documentation formats.

## Prerequisites

For broad compatibility, all tools utilized are constrained to those included
in a standard TeX Live distribution. Therefore, `texlive` (linux), `MacTeX` (macOS), `MikTex` (Windows) or Container thereof is required.

Additionally, it's worth making sure that `dvisvgm` [successfully locates](
https://dvisvgm.de/FAQ/) the GhostScript dynamic library on your system via
`dvisvgm -V1`.

## Usage

The included Makefile contains all commands to render the graphics assets.
Use the `tex` target to generate the PDF output and the `svg` target to
generate the SVG output. Note that the later command is dependent on the
former. For convenience, the `all` target runs both sequential. Additionally,
the `clean` removes the TeX artifacts while `distclean` removes both artifacts
and outputs.

## Implementation

After considering various options, the most straightforward approach seemed
to be to use `latexmk` to delegate `latex` to generate `DVI->PDF` and `dvisvgm`
to convert `DVI->SVG` using a Makefile. As a more modern alternative, it's
also possible to use `xelatex` to generate `XDV->PDF` and `dvisvgm` to convert
`XDV->SVG`.

## Future Work

- [ ] Avoid specifying GhostScript dynamic library path through environmental
variable
- [ ] Add option for using `xelatex`
- [ ] Try `dvisvgm` TikZ package [option](https://tikz.dev/drivers#sec-10.2.4)

## Challenges

It's technically possible to use the `standalone` LaTeX package to export
bitmap and vector graphics with the `convert` configuration option. Martin
Scharrer, the author of `standalone`, elaborates on that point in a Stack
Exchange [answer](https://tex.stackexchange.com/a/51766). However, I had a
some difficulty getting this method to operate as intended with `latexmk`.

### Issue #1: Shell Escape
At first, the conversion failed to execute without the latexmk `-shell-escape`
option. Note that `latexmkrc` file would need entries like:

```
$latex = 'latex -shell-escape';
```

as a required option each interpreter(`latex`, `xelatex`, etc.). This would be
fine if not for the second issue.

### Issue #2: GhostScript

After that, the conversion failed due to [dvisvgm](https://dvisvgm.de) being
unable to locate the GhostScript dynamic library path. This may be a primarily
macOS and Homebrew [issue](https://tex.stackexchange.com/a/559650). With:

```
export LIBGS=/opt/homebrew/Cellar/ghostscript/[version]/lib/libgs.dylib
```

the `dvisvgm` generated the expected output with the Makefile.

However, as alluded to before with the `-shell-escape` option, the dynamic
library path would need to be fixed globally for `latexmk` to spawn another
shell to successfully execute the `convert` configuration option.

To avoid adding any OS-specific configuration to this codebase, this repository
will assume a functional GhostScript support until this issue can be resolved.