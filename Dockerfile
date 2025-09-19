FROM python:3.11-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg git curl \
 && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir yt-dlp spleeter

# Create work directory
WORKDIR /work

# Copy entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

