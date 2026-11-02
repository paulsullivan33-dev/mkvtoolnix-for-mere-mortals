# The Neighbours

MKVToolNix shares the desk with tools
that touch the same files for different
reasons. These are characterisations
from the projects' own documentation,
not benchmarks; the lab ran
MKVToolNix for real and ffmpeg only as
its fixture-maker and second witness.

## ffmpeg: the engine room

ffmpeg is the converter underneath
almost everything: it decodes and
re-encodes, which means it can change
the contents themselves — resolution,
quality, format, filters, loudness.
It can also *remux* (`-c copy`), the
same trick as mkvmerge, and for a
quick one-off that may be all you
need. The honest differences are of
degree and focus: MKVToolNix speaks
Matroska natively and in full —
track flags, chapters, tags,
attachments, editions, splitting and
appending as first-class operations —
while ffmpeg's Matroska support is
one output format among hundreds,
driven through generic stream
machinery. Reach for ffmpeg when the
media must *change*; reach for
MKVToolNix when only the box must.
This series' ffmpeg guide teaches the
engine room properly.

## HandBrake: the shrinker

HandBrake exists to make video files
smaller and more compatible by
re-encoding them, with sensible
presets. Its whole job is the one
MKVToolNix refuses: trading quality
and time for bytes. If your problem is
"this file is 4 GB and must be 800 MB",
that is HandBrake (or ffmpeg), and no
shame attaches. If your problem is
"the wrong soundtrack plays first",
HandBrake would rebuild your film to
fix a label; chapter 6 fixes it in a
second.

## VLC: the witness

VLC plays nearly anything and is the
natural way to *see* the result of
this guide's work — which track a
player picks, whether the chapters
show. It also converts, in the way a
Swiss Army knife saws: present, and
not the tool for joinery. In this
guide's method VLC's role is the one
the lab replaced with measurement:
playback is a check, not an operation.

## Avidemux: the graphical cutter

Avidemux is the GUI neighbour: a video
editor-lite that cuts, appends and
remuxes (its copy mode) with a
timeline you can see, and re-encodes
when you ask. For a sighted,
one-film-at-a-time workflow it is
genuinely pleasant. It is a desktop
program doing one file interactively;
MKVToolNix is a toolbox that scripts,
batches, and runs on a machine with
no screen at all.

## MP4Box: the other container's tool

MP4Box (from the GPAC project) is to
the MP4 container roughly what
MKVToolNix is to Matroska: track
surgery, splitting, joining, hinting,
for the `.mp4` world. If your library
lives in MP4 and must stay there
untouched by re-encoding, it is the
counterpart to know. This guide's
toolbox, by contrast, reads MP4
happily as an *input* but writes
Matroska (or WebM) as its output.

## The GUI in the family

And the closest neighbour of all:
`mkvtoolnix-gui`, the same project's
graphical program — mkvmerge with
windows, a chapter editor, a header
editor that is mkvpropedit with
forms. Nothing in this guide is
GUI-shaped, but every concept is: the
GUI's checkboxes are chapter 6's
flags, its merge list is chapter 4's
command wearing a list box. If you
have a screen, learning either teaches
the other.
