# Recipes

**Outcome: four jobs people actually
bring to this toolbox, done end to end
with the chapters' verified moves.**
Transcript `t08` covers the first two
runs; the other two compose checks
from chapters 5 and 9.

## 1. Add a subtitle track to a finished film

The film exists; a subtitle file
arrives later — a translation, a
correction, an easier-to-read edition.
The finished MKV is simply another
input to mkvmerge:

```bash
mkvmerge -o with-largeprint.mkv film.mkv \
  --track-name 0:"Subtitles (large print)" \
  --language 0:eng largeprint.srt
```

The lab's run (t08) took the finished
sample from four tracks to five, the
new track last, wearing the name and
language given. Everything already in
the file — tracks, chapters,
attachments — rides along untouched.
Afterwards, chapter 6's move sets the
flags so the player starts with the
subtitle track you intend.

## 2. Remove a track you do not want

The mirror job: a file carries a
commentary, a dub, a subtitle language
nobody here reads. mkvmerge selects
tracks by ID with `--audio-tracks`,
`--video-tracks`, `--subtitle-tracks`
(audio shown; the lab kept only audio
track 1, the soundtrack):

```bash
mkvmerge -o no-commentary.mkv \
  --audio-tracks 1 film.mkv
```

Result, verified by the track table:
video, soundtrack, subtitles — the
commentary gone, and the remaining
tracks renumbered cleanly from 0. This
is a rebuild into a new file (the
contents are copied, still never
re-encoded), because mkvpropedit edits
properties, not membership.

## 3. Make the player start the right soundtrack

Not a merge at all — the ten-second
fix from chapter 6. The film starts
with the commentary because every
track claims to be default:

```bash
mkvpropedit film.mkv \
  --edit track:a2 --set flag-default=0
```

Leave exactly one default per type:
the main soundtrack among audio, the
main subtitle (if any should start
on) among subtitles. Verify with the
track table before and after; the
check is the recipe.

## 4. Audit a file before you share it

A file's labels travel with it
(chapter 9). Three read-only commands
state what a recipient — or their
software — can learn from it:

```bash
mkvmerge --identify film.mkv
python3 track-table.py film.mkv
mkvextract film.mkv tags film-tags.xml
```

Tracks and flags from the first two;
every tag — including inherited
encoder stamps and statistics — in
the XML the third writes. If anything
there is not yours to broadcast,
replace the global tags with your own
(chapter 9's `--tags global:` move);
mkvpropedit also *removes* a tags
section when the filename after the
selector is left empty. Ten seconds
of reading beats explaining a file's
worth of metadata later.
