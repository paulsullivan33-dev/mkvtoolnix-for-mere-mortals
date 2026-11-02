#!/usr/bin/env python3
"""Print one row per track of a media file, from mkvmerge's
JSON identification output: id, type, codec, language, the
default and forced flags, and the track name.

Usage: track-table.py FILE
Works on any file mkvmerge can identify, not just MKV.
"""
import json
import subprocess
import sys

data = json.loads(
    subprocess.run(
        ["mkvmerge", "-J", sys.argv[1]],
        capture_output=True, text=True, check=True,
    ).stdout
)
props = data["container"].get("properties", {})
print(f"container: {data['container']['type']} | title: {props.get('title')}")
for track in data["tracks"]:
    p = track["properties"]
    print(
        f"id {track['id']} | {track['type']} | {track['codec']} "
        f"| lang: {p.get('language')} | default: {p.get('default_track')} "
        f"| forced: {p.get('forced_track')} | name: {p.get('track_name')}"
    )
