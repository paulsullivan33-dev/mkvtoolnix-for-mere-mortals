# Glossary

**Append** — joining files end to end
in one timeline, spelled with a `+`
between them in mkvmerge. Requires
matching tracks and codecs.

**Attachment** — a whole file stored
inside a Matroska file: a poster
image, a subtitle font, notes.
Extracted back byte for byte.

**Byte order mark (BOM)** — a three
byte signature (EF BB BF in hex) some
tools write at the start of UTF-8
text. mkvextract puts one at the
front of extracted subtitle files.

**Chapter atom** — one chapter mark:
a start time (an end time, too,
sometimes) and a display name. Atoms
live inside a chapter edition.

**Chapter edition** — a named set of
chapter atoms; a file can hold more
than one edition (a DVD's several
chapterings are the classic case).

**Cluster** — the part of a Matroska
file that holds the actual frames,
grouped in time order. The bulk of
every file.

**Codec** — the format in which
picture or sound itself is compressed
(H.264, VP9, AAC…). The container
holds codecs; it is not one.

**Codec ID** — Matroska's name for a
track's codec, as mkvinfo prints it:
`V_MPEG4/ISO/AVC`, `A_AAC`,
`S_TEXT/UTF8`.

**Container** — the box format
(Matroska, MP4, WebM) that holds
tracks, labels and indexes together
in one file.

**Cues** — the Matroska index: where
the keyframes live, so players can
seek without reading everything.

**Default track flag** — the property
saying "start with this one" among
tracks of the same type. Set with
mkvmerge's `--default-track` or
mkvpropedit's `flag-default`.

**EBML** — Extensible Binary Meta
Language: the binary, XML-like
structure Matroska files are built
from. mkvinfo's tree is EBML elements.

**Elementary stream** — a track with
no container around it: raw frames in
order, as mkvextract writes. No room
in it for names, flags or chapters.

**Forced track flag** — the property
saying "show this track even when its
type is switched off" — for subtitle
tracks carrying the few lines everyone
must read. mkvpropedit's `flag-forced`.

**Keyframe** — a frame that decodes
by itself, without reference to
others. Splits and seeks can only
start at keyframes.

**Language tag** — a track's language
code (`eng`, or a fuller BCP 47 tag).
Players use it when choosing which
soundtrack or subtitles to start.

**Matroska** — the open container
format this toolbox serves; its video
files end in `.mkv` (audio `.mka`,
3D `.mk3d` exist and are rare).

**Multiplexing (muxing)** — combining
tracks into a container without
re-encoding them. The reverse,
taking a file apart into its tracks,
is demultiplexing.

**Segment** — the whole film inside
the file: one segment per file,
holding the information, tracks,
clusters, chapters, tags and
attachments.

**Segment information** — the
file-level labels: title, duration,
writing application, segment UID.

**Statistics tags** — per-track tags
mkvmerge writes by default
(`BPS`, `DURATION`, `NUMBER_OF_FRAMES`,
`_STATISTICS_*`). Useful facts that
also announce themselves; can be left
off with `--disable-track-statistics-tags`.

**Tag** — a name-and-value pair
(`TITLE`, `DIRECTOR`, your own
invention) attached to the whole file
or to one track, stored as XML-shaped
data in the file.

**Track** — one stream of contents
inside the container: video, audio,
subtitles, each with its own codec,
language, name and flags.

**Track ID** — the 0-based number
mkvmerge and mkvextract use for a
track. Not the same as the track
number.

**Track number** — the 1-based
position of a track in the file, as
mkvinfo prints it. Not the same as
the track ID.

**Track UID** — a track's permanent
unique number, kept across edits;
used to keep tag and chapter
references attached to the right
track.

**WebM** — Matroska's restricted
cousin for the web: a subset of the
format with a fixed codec list,
which mkvmerge writes with `--webm`.
