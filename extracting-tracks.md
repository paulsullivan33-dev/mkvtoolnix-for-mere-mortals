# Extracting Tracks

**Outcome: the tracks inside an MKV
come back out as standalone files —
video as a raw stream, audio as a raw
stream, subtitles as a text file —
each verified against what went in.**
The full run is transcript `t05`.

## The command

```bash
mkvextract lighthouse.mkv tracks \
  0:video.h264 \
  1:soundtrack.aac \
  3:subs.srt
```

The grammar: the source file, the mode
word `tracks`, then pairs of **track
ID** and output name. The IDs are the
ones from chapter 5's identification
(0 video, 1 and 2 audio, 3 subtitles);
a wrong ID is a plain error — "No
track with the ID 9 was found in the
source file", exit code 2, no file
created (t07, case 3). mkvextract
narrates each extraction with the form
the result takes: "Container format:
AVC/H.264 elementary stream",
"…raw AAC file with ADTS headers",
"SRT text subtitles".

*Elementary stream* is the key idea:
extraction removes the container
entirely. The video is the same H.264
data with no box around it — no
timestamps file, no chapters, nothing
but frames in order. That is exactly
what you want as input to another
mux, and exactly what disappoints if
you expected a playable `.mp4`.

## The checks

Three verifications, one per kind:

- **Video:** ffprobe counts the
  extracted stream's frames:
  **120 frames**, 320×240, codec h264.
  The fixture was 12 seconds at 10
  frames per second — 120 is the whole
  film, frame for frame.
- **Audio:** ffprobe reads the AAC
  file: 44,100 Hz mono AAC, duration
  00:00:11.89 — the full tone, short a
  final partial frame's worth of
  arithmetic, not of sound.
- **Subtitles:** `diff` against the
  SRT that went in. Not byte-identical
  — and the two differences are both
  cosmetic and both worth knowing.
  mkvextract begins text extractions
  with a UTF-8 **byte order mark** (the
  first bytes are 357 273 277 in octal,
  shown in the transcript), and ends
  the file with an extra blank line.
  Every cue, every timestamp and every
  word matches: the subtitle *content*
  round-trips whole.

## The honest edges

Extraction is faithful to the
*contents*, not to the *container*.
Track names, flags, languages and
chapters do not ride along into an
elementary stream — there is nowhere
in a raw H.264 stream to write them.
If the labels matter, they are
re-applied at the next merge
(chapters 4 and 6 are the tools).
Likewise a *selection* of audio
channels or a resample is not on
offer: mkvextract takes a track out
whole, as it is. Anything that changes
the contents themselves is, as ever,
a converter's job.

The other extraction modes — chapters
and tags out as XML, attachments out
as files — get their own workout in
the next chapter, where the lab first
puts those things *in*.
