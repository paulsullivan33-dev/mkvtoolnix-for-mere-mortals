# The Moving Parts

**Outcome: you can say which of the
four tools touches which part of a
Matroska file — and why a job that
sounds like one task ("fix this film")
is usually a specific tool's ten-second
task, not an afternoon in a
converter.** Nothing here needs
installing yet; chapter 3 does that.

## The four tools

MKVToolNix is four command-line
programs (and a graphical fifth this
guide describes but does not run):

- **`mkvmerge`** builds Matroska files.
  It reads almost any media file,
  takes some or all of its tracks, and
  writes one `.mkv` — merging, and
  also splitting and appending, which
  are building operations too. If a
  file is being *created*, mkvmerge is
  doing it.
- **`mkvinfo`** reads. It prints the
  file's structure as a tree — every
  element, in order — and, at higher
  verbosity, every frame. It changes
  nothing.
- **`mkvpropedit`** edits properties in
  place. Titles, track names,
  languages, flags, chapters, tags and
  attachments can be changed on an
  existing file without rebuilding it:
  the media data is never touched,
  which is why its edits take a second
  on a file of any size.
- **`mkvextract`** takes pieces out:
  tracks as raw streams or subtitle
  files, chapters and tags as XML,
  attachments as the files they were.
- **`mkvtoolnix-gui`** is the graphical
  program wrapping the same engine —
  the merge tool with windows, plus
  chapter and header editors. It lives
  in its own package and needs a
  display; this lab had neither, so it
  is documented-only here.

## The parts of the file

A Matroska file is built from nested
elements (the format underneath is
**EBML**, a binary cousin of XML).
You meet these parts in mkvinfo's
tree, so learn their names once:

- The **segment** is the whole film:
  one per file.
- **Segment information** holds the
  file-level labels: the **title**, the
  duration, the writing application,
  a unique segment ID.
- **Tracks** are the contents: each has
  a number, a permanent **track UID**,
  a type (video, audio, subtitles), a
  **codec ID** naming its format, and
  properties — name, language, and the
  **default** and **forced** flags that
  steer players.
- **Clusters** hold the actual frames,
  grouped in time order. They are the
  bulk of the file and the part no
  tool in this box ever decodes.
- **Cues** are the index: where each
  keyframe lives, so players can seek.
  mkvmerge writes them at the end of
  every merge ("The cue entries (the
  index) are being written…").
- **Chapters** are named time marks,
  grouped in an **edition**; each mark
  is a **chapter atom** with a start
  time and a display name.
- **Tags** are name-and-value pairs —
  `TITLE`, `DIRECTOR`, your own
  inventions — attached to the whole
  file or to single tracks.
- **Attachments** are whole files
  stored inside: poster images,
  subtitle fonts, anything.

Two numbering systems run through
everything, and confusing them is the
most common beginner's mix-up. The
**track number** (1, 2, 3…) is the
track's position in this file, printed
by mkvinfo. The **track ID** (0, 1, 2…)
is what mkvmerge and mkvextract use on
the command line — mkvinfo prints both,
in one line: "Track number: 2 (track ID
for mkvmerge & mkvextract: 1)".
mkvpropedit's selectors are a third
way of pointing: `track:v1`, `track:a2`,
`track:s1` mean the first video, second
audio, first subtitle track. Chapter 6
uses all of these.

## Check

Once chapter 3 has installed the
tools, this chapter's map can be
verified against any MKV file in one
command — chapter 5 walks it properly:

```bash
mkvinfo some-film.mkv
```

Every heading above appears in that
output, in that order.
