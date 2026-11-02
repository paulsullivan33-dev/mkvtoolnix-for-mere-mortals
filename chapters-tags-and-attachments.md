# Chapters, Tags and Attachments

**Outcome: one file gains chapter
marks, descriptive tags and an
attached poster — all three added in
place with mkvpropedit — and all three
are then extracted back out and
verified, the attachment by checksum.**
The full run is transcript `t06`. This
is also the chapter where the guide's
standing warning lives: a Matroska
file's metadata travels with it, in
both directions.

## First, what a file already says

Before adding anything, the lab
extracted the tags from the chapter-4
merge — a file nobody had deliberately
tagged:

```bash
mkvextract lighthouse.mkv tags out.xml
```

It was not empty. Each source file's
`ENCODER` tag (ffmpeg's library stamp,
`Lavf62.12.102`) had been carried into
the merge, and mkvmerge had added its
own **statistics tags** per track —
`BPS`, `DURATION`, `NUMBER_OF_FRAMES`,
`NUMBER_OF_BYTES`, stamped with
`_STATISTICS_WRITING_APP` and the date.
None of this is sinister; all of it is
informative. It is also the general
case with real media: files accumulate
the names of the tools that touched
them, the dates they were written, and
the shape of their contents. **Before
you share a media file, its tags are
worth the ten seconds mkvextract
takes.** The statistics tags can be
left off at merge time with
`--disable-track-statistics-tags`;
tags you did not write cannot be
un-written except by replacing them,
which is what the next section does.

## Adding all three

Chapters and tags are XML files in
Matroska's own formats; the lab's two
fixtures ship in the lab folder
(`chapters.xml`: three marks —
"Opening titles", "The harbour at
dawn", "The forecast"; `tags.xml`:
TITLE, DIRECTOR, DATE_RELEASED and a
COMMENT for the invented film). Both
go on with mkvpropedit, in place:

```bash
mkvpropedit finished.mkv --chapters chapters.xml
mkvpropedit finished.mkv --tags global:tags.xml
mkvpropedit finished.mkv \
  --attachment-name "Poster (sample)" \
  --attachment-description \
    "A flat blue rectangle, 64 by 96" \
  --add-attachment poster.png
```

Notes that save experiments:

- `--tags` takes a **selector**: `all:`,
  `global:`, or a track selector,
  then the filename. `global:` is the
  usual want — file-level facts.
- Attachment options (`--attachment-name`,
  `--attachment-description`,
  `--attachment-mime-type`) apply to
  the `--add-attachment` that *follows*
  them.
- Replacing works the same way
  (`--replace-attachment`,
  `--delete-attachment`), and empty
  filenames to `--chapters`/`--tags`
  remove those sections entirely.

## The checks

Identification now reports the full
file:

```text
Attachment ID 1: type 'image/png', size 210 bytes, description 'A flat blue rectangle, 64 by 96', file name 'Poster (sample)'
Chapters: 3 entries
Global tags: 4 entries
```

And extraction closes the loop:

```bash
mkvextract finished.mkv chapters chapters-out.xml
mkvextract finished.mkv tags finished-tags.xml
mkvextract finished.mkv attachments 1:poster-out.png
```

The chapter marks come back with their
exact start times and names (inside
one **edition** — the JSON count of
"chapters: 1" counts editions, and the
transcript says so, because editions
vs marks confuses everyone once). The
tags come back with the four values
the lab set. And the poster comes back
byte for byte: `md5sum` of the file
that went in and the file that came
out agree — `df6ab3a3…` on both lines.
Attachments are cargo, carried
unchanged; the checksum is the proof
this chapter promised in its first
paragraph.

What players *do* with all this varies
— chapter marks are widely honoured,
posters often, exotic tags rarely —
and chapter 12 keeps that honesty.
What the file *holds* is now yours to
state, check and, when sharing,
deliberately choose.
