# What MKVToolNix Is

You have a video file, a soundtrack in
another file, and subtitles in a third,
and you want one file that plays as a
film. Or the reverse: a film whose
subtitles you need as a text file. Or a
film that starts with the wrong
soundtrack, a recording too large to
send, a title that says
`final_FINAL_v2`. The familiar tools
for this — the converters — solve it by
rebuilding the whole thing: decode
every frame, encode it again, wait, and
accept a small loss of quality as the
price. **MKVToolNix is the tool that
skips that price.** It works on the
*container* — the box the picture,
sound and subtitles travel in — and
leaves the contents alone.

The container here is **Matroska**, the
format whose files end in `.mkv`.
Inside, the contents are kept as
separate **tracks**: a video track, one
or more audio tracks, subtitle tracks,
each labelled with a language, a name
and flags saying which ones a player
should start with. Around the tracks
sit chapter marks, descriptive **tags**
(title, director, year — or anything
else) and **attachments**, whole files
riding inside: a poster image, a font
for the subtitles, a notes file.
MKVToolNix is the toolbox for that box:
one program that builds and rebuilds it
(`mkvmerge`), one that reads it
(`mkvinfo`), one that rewrites its
labels in place (`mkvpropedit`), and
one that takes pieces back out
(`mkvextract`). Rearranging is called
**muxing** — multiplexing — and it is
fast, because the compressed picture
and sound data is copied, never
decoded. The lab's first merge of a
twelve-second film, four sources into
one file, took mkvmerge less than a
second and reported it plainly:
"Multiplexing took 0 seconds."

That speed and exactness are the
feature. The same one-two of copying
instead of converting is also the
limit, and chapter 12 states it in
full: MKVToolNix cannot make a file
smaller by quality, cannot fix a bad
recording, cannot turn a format the
player hates into one it loves. If the
*contents* must change, you want a
converter (chapter 11). If the contents
are right and the *box* is wrong —
tracks missing, tracks extra, labels
lying, pieces in the wrong files — you
want this.

## A first taste

After installing (chapter 3), merging
is one command. This is the lab's first
merge (chapter 4 tells it in full):

```bash
mkvmerge -o lighthouse.mkv \
  --title "The Lighthouse at Gull Rock" \
  video.mp4 soundtrack.m4a \
  commentary.m4a sample-subs.srt
```

Four files go in; one file comes out,
holding a video track, two audio
tracks and a subtitle track, with the
title set. Nothing was re-encoded: the
H.264 picture and AAC sound are the
same compressed data, wearing a new
box. Every later chapter is a variation
on that sentence — reading the box,
relabelling it, cutting it, opening it.

## What it is not

It is not a player: nothing here shows
you the film, and the checks in this
guide are measurements — durations,
frame counts, checksums — not
screenings. It is not an editor in the
cutting-room sense: it can split a file
at chosen times (chapter 7), but only
where the video's keyframes allow, and
it cannot fade, crop or repair. It is
not a converter, as established. And it
is not a lockpick: Matroska is an open
format for unprotected media, the tools
contain nothing that decrypts, and a
file protected by DRM is simply not
something they can open.

## Who it is for

The home media librarian whose films
arrive as separate video, sound and
subtitle files and should live as one.
The archivist renaming and labelling a
collection so players show the right
title and start the right soundtrack.
Anyone who has been sent a film with
the commentary on by default, or who
needs the subtitles *out* of a file as
text. The common thread is one person,
their own media files, and a box that
needs rearranging — quickly, exactly,
and without a quality tax.

## The honest catches, up front

Three, and this guide measures all of
them rather than smoothing them over.
First, the labels are only as good as
what wrote them: merging four
single-track files gave the lab a film
in which **every track claimed to be
the default** (chapter 5 shows it,
chapter 6 fixes it). Second, splitting
and joining are not mirror images:
chapter 7 joins the lab's pieces back
together and the result runs 16.03
seconds against the original's 12.03,
for a reason the chapter names.
Third, the tools are polite to a fault
about damage: a file cut off at 30,000
bytes passed every check with exit
code 0 while holding 4 of its 120
frames (chapter 13). None of these is a
reason to avoid the toolbox. All of
them are reasons to verify — which is
this series' standing habit, and this
guide's chapters show the check for
every claim.
