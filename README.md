# YouTube Cleaner (Voice Only)

A Dockerized tool to remove background music from YouTube videos using [Spleeter](https://github.com/deezer/spleeter).

## Features
- Downloads any YouTube video
- Separates voice from background music
- Replaces the video’s audio track with clean speech
- Outputs directly to your local `./out` folder

## Setup
Clone this repo and build the Docker image:

```bash
git clone https://github.com/gregory-chatelier/youtube-cleaner.git
cd youtube-cleaner
docker build -t youtube-cleaner .
```

## Usage

### Windows

Use the `run.bat` script:
```batch
run.bat "https://www.youtube.com/watch?v=VIDEO_ID"
```

### macOS / Linux / WSL

Use the `run.sh` script:
```bash
./run.sh "https://www.youtube.com/watch?v=VIDEO_ID"
```

The cleaned video will be in:
```
./out/cleaned_video.mp4
```

## Notes

-   For **personal use only** (respect YouTube ToS and copyright).
-   Works best on speech-heavy videos with clear separation.

## Disclaimer

This project was quickly generated with the help of an AI assistant and has only been partially tested. Use at your own risk.
