# Troubleshooting

**Outcome: the failures this guide's
lab met — seven deliberate, one
cosmetic — each with the tool's exact
words, what they mean, and the move
that fixes or catches them.** The full
runs are transcripts `t07` (and `t05`
for the last entry).

## "could not be opened for reading"

```text
Error: The file 'fixtures/no-such-file.mp4' could not be opened for reading: open file error.
```

mkvmerge, exit code 2. The input path
is wrong — a typo, a moved file, a
relative path from the wrong folder.
Nothing was written. Check the path
with `ls` and rerun; note that
mkvmerge fails on the *first* missing
input, so a long command may need
this fixed one file at a time.

## "No EBML head found"

```text
(MKVInfo) No EBML head found. This file is probably not a Matroska file.
```

mkvinfo, exit code 2, asked to read an
MP4. mkvinfo reads Matroska and only
Matroska. For "what is in this file?"
on an unknown container, use
`mkvmerge --identify` instead — it
recognises the formats mkvmerge
reads, which is nearly all of them.

## "No track with the ID 9 was found"

```text
Error: No track with the ID 9 was found in the source file.
```

mkvextract, exit code 2, and no output
file created. The ID does not exist in
this file — most often a track number
(1-based, mkvinfo's left column) used
where a track ID (0-based) was wanted,
or an ID from a different file.
Re-identify the file (chapter 5) and
copy the IDs from its own list.

## "No track corresponding to the edit specification"

```text
Error: No track corresponding to the edit specification 'a9' was found. The file has not been modified.
```

mkvpropedit, exit code 2 — the
reassuring failure. The selector
matched no track, and the message says
the important part out loud: **the
file has not been modified**. Your
typo edited nothing. Count the tracks
of that type (`a1` is the *first
audio*), and rerun.

## "The formats do not match"

```text
Error: The track number 0 from the file 'video-vp9.mkv' cannot be appended to the track number 0 from the file 'video-only.mkv'. The formats do not match.
```

mkvmerge, exit code 2, on append. The
two files' corresponding tracks use
different codecs (or different codec
settings), and one joined track
cannot change format halfway.
Appending is for files encoded alike
(chapter 7). If the pieces differ,
they must be *converted* into
agreement first — a re-encode, hence
another tool — or kept as separate
files in a playlist.

## It "worked", but the film is twice itself

No error at all: two files listed
**without** the `+` were merged in
parallel — every track of both, side
by side, in one file whose duration
is the longer file's. The lab's
side-by-side of two 4-track pieces
came out with **8 tracks** and a
duration of 7.50 s. The check that
catches it is the track table: count
the rows. The fix is the plus sign —
appending is opt-in, spelled `+`,
every time.

## Exit code 0, and the film is still broken

The quietest failure in the guide,
and the reason this chapter exists.
A file truncated partway reads
cleanly: mkvinfo exits 0 at both
verbosity levels, mkvextract reports
100% — and the extracted video holds
4 of 120 frames. Readers in this
toolbox treat end-of-file as an
ending, not an injury.

The defence is measurement, and it is
cheap: after any operation whose
result matters, compare **durations**
(ffprobe, against the source),
**frame counts** for extracted video
(`ffprobe -count_frames`), and
**checksums** for attachments and any
file whose bytes must survive exactly
(`md5sum` on both sides, as chapter 9
did). A green exit code says the tool
finished its sentence. The numbers
say whether the sentence was true.

## The subtitles differ by three invisible bytes

`diff` reports your extracted SRT as
different from the one that went in,
and shows nothing visible. The first
bytes are a UTF-8 byte order mark
mkvextract writes at the front of text
extractions, plus one trailing blank
line at the end (t05). Strip the BOM
before diffing in scripts, and treat
the content — cues, timings, words —
as the comparison that matters.
