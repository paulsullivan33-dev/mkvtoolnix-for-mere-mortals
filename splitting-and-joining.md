# Splitting and Joining

**Outcome: a file cut into pieces by
time or by size, and pieces joined end
to end into one file — plus the
measured reason the joined file is not
the original restored.** The full runs,
including the surprise, are transcript
`t04`.

## Splitting by duration

```bash
mkvmerge -o parts/scene.mkv \
  --split duration:00:00:05 lighthouse.mkv
```

`--split` is an mkvmerge option: the
same tool that builds the file cuts
it. The output name gains numbers —
`scene-001.mkv`, `scene-002.mkv`,
`scene-003.mkv` — and mkvmerge reports
each split decision as it goes. Two
things to know before the output
surprises you:

- Splits happen at **keyframes** —
  the self-contained frames a player
  can start from — because a part must
  be playable from its first frame.
  Ask for 5-second pieces and you get
  pieces of *about* 5 seconds, cut at
  the nearest keyframe.
- Everything in the file is cut,
  including subtitles — and a subtitle
  cue that starts before the cut is
  written whole into the earlier part.

The lab's pieces measured **7.5 s,
6.5 s and 2.03 s** — not the 5, 5, 2
the arithmetic promised. The probe
that explains it is in the transcript:
per stream, only the *subtitle* track
carries those lengths. Cue 2 of the
sample runs 00:04.5 → 00:07.5, so part
1 honestly lasts until 7.5; part 2
begins at its own zero but runs to the
end of cue 3 (00:11.5 in the original),
6.5 s of declared length. The picture
and sound were cut at the keyframes on
request; the *durations* are stretched
by cues straddling the joins.

## Splitting by size

```bash
mkvmerge -o sized/chunk.mkv \
  --split size:200k lighthouse.mkv
```

Same mechanism, different budget: a
part is closed once it would exceed
the size, again at a keyframe. The
lab's 497,667 bytes became three
chunks. Splitting also accepts
timestamps (`--split timestamps:`), a
list of cut points, and chapter-based
modes; the man page enumerates them,
and the keyframe rule governs them
all.

## Joining: the plus sign

```bash
mkvmerge -o rejoined.mkv \
  parts/scene-001.mkv + parts/scene-002.mkv \
  + parts/scene-003.mkv
```

The `+` between files means **append**:
play this file, then this one, in one
timeline. (No plus means something
entirely different — chapter 13 shows
the pile-up it makes.) Appending is
strict, by design: every file must
bring the **same tracks with the same
codecs and settings**, because the
joined file has one set of track
headers for the whole timeline.
mkvmerge checks and refuses mismatches
with a plain error (t07, case 5: an
H.264 file and a VP9 file "cannot be
appended… The formats do not match.").
When no mapping is specified it maps
tracks in order and says so — the
"No append mapping was given" notices
in the transcript are information, not
complaints.

## The measured catch

The lab then probed the rejoined file:
all four tracks present, correct
names, and a duration of
**00:00:16.03** — four seconds longer
than the film that was cut. The cause
chains directly from the split: when
appending, mkvmerge offsets each file
by the **declared durations** of the
files before it, and those were the
subtitle-stretched 7.5 and 6.5.
7.5 + 6.5 + 2.03 = 16.03. The picture
and sound are all present, in order;
the timeline carries the extra time at
the joins, as gaps a player steps
over.

So: split parts are excellent for
*sending* and *storing* — each part
plays on its own — and appending is
the right tool for files that were
born separate (two recordings of one
event, matching tracks). But split →
append is not a lossless round trip
for the *timeline*, and on media where
a straddling subtitle or a long final
frame can stretch a part's declared
duration, the join inherits the
stretch. Measure after joining, the
way the lab did: track table, then
duration, against the original.
