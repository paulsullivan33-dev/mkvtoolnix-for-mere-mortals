# Limits

**Outcome: you can name what this
toolbox will never do, and recognise
the jobs to take elsewhere before you
start.** Each limit below was met in
the lab, not read in a brochure; the
transcripts carry the evidence.

## It never re-encodes

The founding limit, stated as a
feature everywhere else in this guide,
is still a limit. MKVToolNix cannot
make a file smaller by quality, change
a resolution, fix an overexposed
picture, level the sound, or convert
H.264 into something a picky player
accepts. Contents in, same contents
out — if the contents are the problem,
chapter 11's converters are the
answer, and no option in these four
tools will change that.

## Appending is strict

Files join only if their tracks match
in number, codec and settings —
because the joined file has one track
header per track, not per piece. An
H.264 piece and a VP9 piece refuse
with "The formats do not match" (t07).
Real-world collections, encoded by
different tools at different times,
fail this test more often than they
pass it; appending is for files born
alike.

## Splits are keyframe-bound, joins inherit durations

A split can only happen where a
player could start: a keyframe. Ask
for five-second pieces of sparsely
keyframed video and the pieces will
be longer than five seconds. Worse,
and measured in chapter 7: a part's
declared duration can be stretched by
content that straddles the cut — the
lab's subtitle cue stretched 5-second
pieces to 7.5 and 6.5 — and appending
trusts declared durations as offsets,
so the rejoined file ran 16.03 s
against the original's 12.03. Split
for sending; do not expect split and
append to cancel out.

## Labels are only as honest as their sources

mkvmerge keeps the flags and much of
the metadata it is handed. Four
well-behaved single-track files merged
into one film in which every track
claimed to be the default (chapter
5), and the merge inherited encoder
tags nobody asked about (chapter 9).
Neither is a bug; both mean *merging
is not finishing* — the track table
check at the end is part of the job.

## The tools are too polite about damage

A file truncated to its first 30,000
bytes passed mkvinfo at both
verbosity levels with exit code 0,
and mkvextract happily reported 100%
progress — while producing a video
track with 4 of its 120 frames (t07).
The readers read what is there and
stop quietly at the end of the world.
Exit code 0 is therefore *not* a
completeness proof for anything in
this toolbox; chapter 13's checks —
frame counts, durations, checksums —
are the proof. This is the limit most
worth remembering, because it hides.

## Smaller print

- **Extraction loses the labels.**
  Elementary streams have nowhere to
  keep names, flags or chapters
  (chapter 8). Keep the source file.
- **Extracted text gains a BOM.**
  Subtitles extracted to text begin
  with a UTF-8 byte order mark and an
  extra blank line (t05). Harmless to
  players; visible to diffs.
- **Output is Matroska (or WebM).**
  mkvmerge reads nearly everything
  and writes `.mkv`/`.webm`. A library
  that must stay MP4 needs chapter
  11's MP4Box, or a remux through
  ffmpeg.
- **Flags are requests.** Players
  honour default and forced flags
  unevenly; the file can only state
  the intent (chapter 6).
- **The GUI needs a screen.**
  Documented-only in this guide, by
  the lab's nature, not the tool's
  fault.
