#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: entrypoint.sh <YouTube_URL>"
  exit 1
fi

URL="$1"
BASENAME="video"
CHUNK_DURATION=600 # 10 minutes in seconds

# Step 1: Download video and audio
yt-dlp -f bestvideo+bestaudio --merge-output-format mp4 -o "${BASENAME}.mp4" "$URL"
yt-dlp -x --audio-format wav -o "${BASENAME}.%(ext)s" "$URL"

# Step 2: Get audio duration
duration=$(ffprobe -i "${BASENAME}.wav" -show_entries format=duration -v quiet -of csv="p=0")
duration=${duration%.*}

# Step 3: Process audio in chunks
vocal_files_list="vocal_files.txt"
> "$vocal_files_list" # Create or clear the file

for i in $(seq 0 $CHUNK_DURATION $duration); do
  chunk_name="chunk_${i}"
  ffmpeg -i "${BASENAME}.wav" -ss "$i" -t "$CHUNK_DURATION" -c copy "${chunk_name}.wav"
  spleeter separate -p spleeter:2stems -o "output" "${chunk_name}.wav"
  echo "file 'output/${chunk_name}/vocals.wav'" >> "$vocal_files_list"
  rm "${chunk_name}.wav"
done

# Debugging
echo "--- DEBUGGING --- "
ls -R output
cat vocal_files.txt
echo "--- END DEBUGGING --- "

# Step 4: Concatenate vocal chunks
ffmpeg -f concat -safe 0 -i "$vocal_files_list" -c copy "vocals_full.wav"

# Step 5: Replace audio track in video
ffmpeg -i "${BASENAME}.mp4" -i "vocals_full.wav" \
  -c:v copy -map 0:v:0 -map 1:a:0 -shortest \
  "cleaned_${BASENAME}.mp4" -y

# Step 6: Move result back to mounted directory
cp "cleaned_${BASENAME}.mp4" /out/

echo "✅ Cleaned video available at ./out/cleaned_${BASENAME}.mp4"
