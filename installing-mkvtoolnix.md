# Installing MKVToolNix

**Outcome: the four command-line tools
on your machine, each able to state
its version — before any media file
enters the picture.** The lab installed
from the Ubuntu package; the project's
own site also ships downloads for other
systems, described at the end.

## The package install

On Ubuntu (the lab machine runs Ubuntu
24.04), one package carries all four
tools:

```bash
sudo apt-get install mkvtoolnix
```

The lab's package was **82.0-1build2**,
and the tools report themselves as
**mkvmerge v82.0 ('I'm The President')**
— each release has a codename, quoted
in the version string. Version numbers
matter with this toolbox: players of
long standing have decades of releases,
and behaviours this guide names (flag
handling, statistics tags) are
82.0's; an older install may differ in
details. The full version evidence is
transcript `t00` in the lab folder.

## The version check

Prove the install before trusting it —
one line per tool:

```bash
mkvmerge --version
mkvinfo --version
mkvpropedit --version
mkvextract --version
```

The lab's output (t00):

```text
mkvmerge v82.0 ('I'm The President') 64-bit
mkvinfo v82.0 ('I'm The President') 64-bit
mkvpropedit v82.0 ('I'm The President') 64-bit
mkvextract v82.0 ('I'm The President') 64-bit
```

Four tools, one version, all answering.
The package query agrees:

```bash
dpkg-query -W mkvtoolnix
# mkvtoolnix    82.0-1build2
```

## The GUI is a separate package

The graphical program is **not** in
`mkvtoolnix`; it ships as
`mkvtoolnix-gui` (the lab's apt offered
it at the same 82.0). It needs a
display to run. The lab machine is
headless — no screen, no way to click —
so this guide does not install or drive
it, and says so wherever the GUI would
be the natural tool: everything it does
can be done by the four command-line
tools, and the chapters show those.
If your machine has a screen, the GUI
is a friendly front end to the same
operations, and the concepts here —
tracks, flags, chapters — transfer
word for word.

## Other systems

The project (mkvtoolnix.download) ships
its own packages and installers for
Windows, macOS and several Linux
distributions, often newer than the
distribution's own. The commands in
this guide are the same everywhere;
only the install step differs. What the
lab verified is the Ubuntu apt path
above; the rest is documented-only,
labelled as such in `criteria.md`.

## The lab's fixture media

The chapters use one small sample film,
built by ffmpeg from nothing: a test
pattern, two sine tones and three
subtitle lines. If you want the exact
files the transcripts used, the lab
folder carries `make-fixtures.sh`,
which regenerates them, plus the
subtitle file itself. Every command in
the chapters also works on real media
files of your own — that is rather the
point — but the transcripts' numbers
(the 497,667-byte file, the 120 frames)
belong to the fixtures.
