# Reading an MKV

**Outcome: given any Matroska file, you
can answer — in seconds, and in a form
a script can use — what tracks it
holds, in what languages, with which
flags, under what title.** The full
runs are transcript `t02`.

## mkvinfo: the tree

```bash
mkvinfo lighthouse.mkv
```

mkvinfo prints the file as the nested
tree chapter 2 promised: the EBML
head, then the segment — segment
information (timestamp scale, the
writing application "mkvmerge v82.0",
duration 00:00:12.028, the title), then
each track with its number, UID, codec
ID and properties, and finally the
first cluster, where the frames begin.
For the lab's file the whole tree is
68 lines. Read it once, slowly, on a
file of your own: every property a
later chapter changes is visible here
first.

Two ways to make that output the wrong
size. `mkvinfo -v` adds every cluster
and every frame — 1,607 lines for our
twelve seconds, and the honest tool
for inspecting frame-level questions.
And `mkvinfo --summary`, despite the
name, prints a one-line digest per
track *and* a line per frame; chapter 4
used it through `grep '^Track'` for
exactly that reason. Plain `mkvinfo`
is the structural view; start there.

## The one-look summary

For the quick question — what is in
this file at all — mkvmerge itself
answers, in its identifier's voice:

```text
$ mkvmerge --identify lighthouse.mkv
File 'work/lighthouse.mkv': container: Matroska
Track ID 0: video (AVC/H.264/MPEG-4p10)
Track ID 1: audio (AAC)
Track ID 2: audio (AAC)
Track ID 3: subtitles (SubRip/SRT)
Global tags: 3 entries
```

Five lines: the container, one per
track with the **track IDs** that
mkvextract will want (0–3, not the
1–4 of mkvinfo's track numbers), and a
count of tag entries. This is the
command to run on an unknown file
before doing anything else to it.

## JSON: reading for scripts

Everything above, machine-readable:

```bash
mkvmerge -J lighthouse.mkv
```

(`-J` is `--identify` with the JSON
format implied.) The output is one
JSON document: `container` with its
properties (title, duration in
nanoseconds, the writing application,
the segment UID), `tracks` as a list —
each with `id`, `type`, `codec`, and a
`properties` object carrying
`language`, `default_track`,
`forced_track`, `track_name` and more —
plus `chapters`, `attachments` and
`global_tags`. One command, no screen
scraping, stable field names: this is
the form to build checks on.

The lab's measuring script,
`mkvtoolnix-lab/track-table.py`, does
exactly that — runs `mkvmerge -J`,
and prints one row per track. On the
lab's film:

```text
container: Matroska | title: The Lighthouse at Gull Rock
id 0 | video | AVC/H.264/MPEG-4p10 | lang: und | default: True | forced: False | name: Picture (test pattern)
id 1 | audio | AAC | lang: eng | default: True | forced: False | name: Soundtrack (440 Hz tone)
id 2 | audio | AAC | lang: eng | default: True | forced: False | name: Commentary (220 Hz tone)
id 3 | subtitles | SubRip/SRT | lang: eng | default: True | forced: False | name: Subtitles
```

There, in one glance, is the finding
chapter 4 promised: `default: True` on
all four tracks. The flags are facts
in the file, not player whims — and
facts in a file can be edited, which
is the next chapter.
