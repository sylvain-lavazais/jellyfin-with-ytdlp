# Jellyfin with yt-dlp

This project extends the official [Jellyfin](https://jellyfin.org/) Docker image by adding:
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) (YouTube downloader)
- [id3v2](https://id3v2.sourceforge.net/) (ID3 tag editor)

These additions enable Jellyfin to download and process media from YouTube and other online sources.

## Features

- Based on the official Jellyfin Docker image
- Includes yt-dlp for downloading videos from YouTube and [other supported sites](https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md)
- Includes id3v2 for editing media metadata
- Multi-architecture support (amd64, arm/v7, arm64/v8)

## Usage

### Docker Pull Command

```bash
docker pull slavazais/jellyfin-with-ytdlp:latest
```

### Running the Container

```bash
docker run -d \
  --name jellyfin \
  -p 8096:8096 \
  -v /path/to/config:/config \
  -v /path/to/cache:/cache \
  -v /path/to/media:/media \
  slavazais/jellyfin-with-ytdlp:latest
```

### Docker Compose

```yaml
version: '3'
services:
  jellyfin:
    image: slavazais/jellyfin-with-ytdlp:latest
    container_name: jellyfin
    ports:
      - 8096:8096
    volumes:
      - /path/to/config:/config
      - /path/to/cache:/cache
      - /path/to/media:/media
    restart: unless-stopped
```

## Building Locally

### Building the Docker Image

To build the Docker image locally:

```bash
docker build -t jellyfin-with-ytdlp .
```

### Multi-Architecture Builds

The project uses Docker Buildx for multi-architecture builds. To build for multiple architectures:

1. Set up Docker Buildx (if not already set up):
   ```bash
   docker buildx create --name mybuilder --use
   ```

2. Build and push for multiple architectures:
   ```bash
   docker buildx build \
     --platform linux/amd64,linux/arm/v7,linux/arm64/v8 \
     --tag yourusername/jellyfin-with-ytdlp:latest \
     --push \
     .
   ```

## Testing

### Testing the Docker Build

To verify that the Docker image builds successfully and the required tools (yt-dlp and id3v2) are installed and working:

```bash
# Build the test image
docker build -t jellyfin-with-ytdlp-test .

# Test yt-dlp
docker run --rm --entrypoint yt-dlp jellyfin-with-ytdlp-test --version

# Test id3v2
docker run --rm --entrypoint id3v2 jellyfin-with-ytdlp-test --version
```

### Debugging

For debugging issues with the container:

1. Run the container with an interactive shell:
   ```bash
   docker run -it --entrypoint /bin/bash jellyfin-with-ytdlp
   ```

2. Check installed package versions:
   ```bash
   apt list --installed | grep package-name
   ```

3. Verify tool functionality:
   ```bash
   yt-dlp --version
   id3v2 --version
   ```

## CI/CD Pipeline

The project uses GitHub Actions for CI/CD:
- Builds are triggered on pushes to the main branch
- Multi-architecture images are built and pushed to Docker Hub

## License

See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
