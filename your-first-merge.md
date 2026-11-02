# Your First Merge

**Outcome: four separate files — video,
soundtrack, commentary, subtitles —
become one MKV holding all four tracks,
titled and labelled, and two
independent tools confirm what is
inside.** The full run is transcript
`t01`.

## The sources

The lab's fixtures (chapter 3 tells how
they were made): `video.mp4`, twelve
seconds of test pattern with no sound;
`soundtrack.m4a` and `commentary.m4a`,
two AAC tones, 440 Hz and 220 Hz,
standing in for a film score and a
commentary; and `sample-subs.srt`,
three subtitle cues. Real work uses
real files in the same shapes; nothing
about the merge changes.

## The command

```bash
mkvmerge -o lighthouse.mkv \
  --title "The Lighthouse at Gull Rock" \
  --track-name 0:"Picture (test pattern)" \
  video.mp4 \
  --track-name 0:"Soundtrack (440 Hz tone)" \
  --language 0:eng \
  soundtrack.m4a \
  --track-name 0:"Commentary (220 Hz tone)" \
  --language 0:eng \
  commentary.m4a \
  --track-name 0:"Subtitles" \
  --language 0:eng \
  sample-subs.srt
```

Read it as a small grammar, because
every mkvmerge command you will ever
write follows it:

- `-o` names the output, once, first.
- Options written **before** a file
  belong to that file. `--track-name
  0:"…"` names track 0 *of the file
  that follows it* — each of our
  sources has exactly one track, so
  every option says `0:`.
- `--language 0:eng` sets the track's
  language (codes are ISO codes;
  players use them when choosing which
  soundtrack or subtitle to start).
- `--title` is the exception: it is a
  property of the *output file*, not
  of any input track.
- The input files come last in each
  group, in the order their tracks
  should appear in the output.

mkvmerge narrates as it works: which
demultiplexer it chose for each input
('QuickTime/MP4' for the video and both
soundtracks, 'SRT subtitles' for the
text), which output module handles each
track, and then the merge itself. The
transcript's ending is the receipt:
"The file 'work/lighthouse.mkv' has
been opened for writing… Multiplexing
took 0 seconds", exit code 0. Copying
compressed data is quick; there was
nothing to decode.

## The checks

Trust, but verify — with two tools that
owe mkvmerge nothing. First, the
one-line-per-track summary (chapter 5
explains the views properly):

```bash
mkvinfo --summary lighthouse.mkv | grep '^Track'
```

The lab's four lines name a video track
(H.264, 320×240), two audio tracks
(AAC, 44100 Hz) and a subtitle track
(S_TEXT/UTF8) — the four inputs, in
order, carrying the languages we set.
The video track's language reads `und`
(undefined): the command never set one,
and mkvmerge does not invent metadata.
What you do not set stays unset — a
principle chapter 6 leans on.

Second, ffprobe, from the ffmpeg
project, reads the same file and agrees
independently: duration **00:00:12.03**,
the file-level title "The Lighthouse at
Gull Rock", four streams with the track
names we gave. The finished file is
497,667 bytes — larger than any single
input, smaller than their sum plus a
film's worth of fuss, because nothing
was re-encoded and almost nothing was
added: some structure, an index, and
the labels.

Two details in that ffprobe output
foreshadow later chapters. Every stream
is marked *(default)* — including both
soundtracks and the subtitles. That is
not what a player should see, and it
happened honestly: each source file's
own single track was *its* default, and
mkvmerge kept the flags it was handed.
Chapter 6 fixes the flags in place.
And the merge quietly inherited tags
from the sources' metadata (chapter 9
opens that box). First, chapter 5
teaches reading a file properly.
