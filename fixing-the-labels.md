# Fixing the Labels

**Outcome: an existing file's title,
track names, languages and flags are
corrected in place, in about a second,
with the picture and sound provably
untouched — no remux, no new file
unless you want one.** More real-world
MKV work lives in this chapter than in
any other. The full run is transcript
`t03`.

## The problem, restated

Chapter 5's table: every track in the
lab's film is flagged **default**. A
player choosing a soundtrack may start
the commentary; subtitles may come up
uninvited. The merge was not wrong —
it faithfully kept each source file's
own flags — but the *combination* is
wrong, and combinations are the file's
problem, not the sources'. The file
also says the video's language is
`und`, and its title could be better.

All of that is header information, and
`mkvpropedit` rewrites headers in
place. No `-o`, no new output file:
you name the file, an `--edit` target,
and `--set` pairs.

## The edit

Work on a copy if the file matters
(the lab copies `lighthouse.mkv` to
`fixed.mkv`); then one command carries
five edits:

```bash
mkvpropedit fixed.mkv \
  --edit info \
  --set "title=The Lighthouse at Gull Rock (evening cut)" \
  --edit track:v1 --set language=eng \
  --edit track:a2 --set flag-default=0 \
  --edit track:a2 \
  --set "name=Commentary (220 Hz tone, alternate take)" \
  --edit track:s1 --set flag-default=0
```

The grammar:

- `--edit info` targets the segment
  information — the file-level title.
- `--edit track:v1`, `track:a2`,
  `track:s1` select by type and order:
  first video, second audio, first
  subtitle track. (`track:2` also
  exists, selecting by track number.)
- Each `--set name=value` writes one
  property. The properties this guide
  uses are `title`, `name`, `language`,
  `flag-default` and `flag-forced` —
  the man page lists the full set,
  mirroring the names mkvinfo prints.

mkvpropedit answers with three lines —
"The file is being analyzed. / The
changes are written to the file. /
Done." — and the checks confirm the
rest. The lab's track table after:

```text
id 0 | video | ... | lang: eng | default: True | name: Picture (test pattern)
id 1 | audio | ... | lang: eng | default: True | name: Soundtrack (440 Hz tone)
id 2 | audio | ... | lang: eng | default: False | name: Commentary (220 Hz tone, alternate take)
id 3 | subtitles | ... | lang: eng | default: False | name: Subtitles
```

One default per type, languages set,
title and track name updated. ffprobe
agrees independently, and its one
eloquent detail: the subtitle stream
no longer wears the *(default)* mark,
while the duration is unchanged at
00:00:12.03 — the media was never in
the room where the labels changed.

## The forced flag

A second, separate edit demonstrates
the other flag:

```bash
mkvpropedit fixed.mkv \
  --edit track:s1 --set flag-forced=1
```

A **forced** subtitle track is one
players show *even when subtitles are
off* — the classic case is a film with
a few lines in another language, which
the author intends everyone to read.
`default` answers "start with this
one?"; `forced` answers "show this one
regardless". They are separate switches
because they answer separate questions,
and players honour them unevenly —
chapter 12 is honest that a flag is a
request, not a command.

## Rules of the house

- mkvpropedit edits the file you name.
  Keep a copy of anything irreplaceable
  until the track table says what you
  meant.
- Several `--edit` blocks ride in one
  run, as above; a selector that
  matches nothing is an error, not a
  shrug (chapter 13 shows its exact
  words) — so a typo fails safely
  instead of silently editing nothing.
- What you can set is properties, not
  contents. To remove a whole track,
  that is a rebuild — mkvmerge with
  the track left out (chapter 10's
  first recipe shows the shape).
