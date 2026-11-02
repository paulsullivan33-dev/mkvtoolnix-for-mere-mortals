#!/bin/sh
# Regenerate this guide's sample media with ffmpeg.
#
# Everything here is synthetic: a moving test pattern, two
# sine tones standing in for soundtracks, a flat colour
# poster, and the stock subtitle lines in sample-subs.srt.
# Nothing is recorded material, and no example is modelled
# on a real film, person or place.
#
# Run from the folder holding this script. The media files
# land in ./fixtures/ -- the transcripts in ./transcripts/
# were recorded with exactly these fixtures.
set -e
mkdir -p fixtures

# Twelve seconds of moving test pattern, video only. A keyframe
# every 25 frames (2.5 s), as in real-world encodes -- the
# splitting chapter depends on keyframes existing.
ffmpeg -hide_banner -loglevel error -y \
  -f lavfi -i testsrc2=duration=12:size=320x240:rate=10 \
  -c:v libx264 -g 25 -pix_fmt yuv420p fixtures/video.mp4

# The "soundtrack": a steady 440 Hz tone, twelve seconds.
ffmpeg -hide_banner -loglevel error -y \
  -f lavfi -i sine=frequency=440:duration=12 \
  -c:a aac fixtures/soundtrack.m4a

# A second, lower tone (220 Hz) to play the commentary track.
ffmpeg -hide_banner -loglevel error -y \
  -f lavfi -i sine=frequency=220:duration=12 \
  -c:a aac fixtures/commentary.m4a

# A tiny flat-colour poster for the attachments chapter.
ffmpeg -hide_banner -loglevel error -y \
  -f lavfi -i color=c=steelblue:size=64x96:duration=0.1 \
  -frames:v 1 fixtures/poster.png

cp sample-subs.srt fixtures/sample-subs.srt

echo "fixtures ready in ./fixtures/"
