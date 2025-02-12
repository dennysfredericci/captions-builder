#!/bin/sh

# Check if the file path is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_video_file>"
  exit 1
fi

VIDEO_FILE=$1

# Check if the file exists
if [ ! -f "$VIDEO_FILE" ]; then
  echo "File not found: $VIDEO_FILE"
  exit 1
fi

# Extract captions and convert to ASS
# whisper --model large --highlight_words True --word_timestamps True --max_line_width 18 --max_line_count 2 --language pt "$VIDEO_FILE" --output_format srt

# Convert SRT to ASS
ffmpeg -i "${VIDEO_FILE%.*}.srt" -c:s ass -metadata:s:s:0 language=pt "${VIDEO_FILE%.*}.ass"

# Replace {\u1} with {\c&H00FFFF&} and  {\u0} with {\c&HFFFFFF&} in the ASS file
sed -e 's/{\\\u1}/{\\c\&H00FFFF\&}/g' -e 's/{\\\u0}/{\\c\&HFFFFFF\&}/g' "${VIDEO_FILE%.*}.ass" > "${VIDEO_FILE%.*}-1.ass"

sed 's|^Style:.*$|Style: Default,Arial Black,24,\&H00FFFFFF,\&H00FFFFFF,\&H00000000,\&H00000000,-1,0,0,0,100,100,0,0,1,3.1,0,2,10,10,10,1|' "${VIDEO_FILE%.*}-1.ass" > "${VIDEO_FILE%.*}-final.ass"

# Bur the ASS to the video.
ffmpeg -i "$VIDEO_FILE" -vf "ass=${VIDEO_FILE%.*}-final.ass" -c:a copy "${VIDEO_FILE%.*}-final.mp4"

