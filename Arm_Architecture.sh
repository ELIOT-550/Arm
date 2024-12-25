#!/bin/bash

# Check system architecture
ARCH=$(uname -m)
echo "Detected system architecture: $ARCH"

# Define download URLs for different architectures
CLOUDFLARED_URL=""
if [ "$ARCH" == "x86_64" ]; then
    CLOUDFLARED_URL="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb"
elif [ "$ARCH" == "arm64" ]; then
    CLOUDFLARED_URL="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Download the correct package
echo "Downloading cloudflared for $ARCH..."
wget -O /tmp/cloudflared.deb $CLOUDFLARED_URL

# Install the package
echo "Installing cloudflared..."
sudo dpkg -i /tmp/cloudflared.deb

# Fix dependencies if needed
echo "Fixing dependencies..."
sudo apt-get install -f -y

# Verify installation
echo "Verifying installation..."
cloudflared --version

if [ $? -eq 0 ]; then
    echo "Cloudflared installed successfully!"
else
    echo "Cloudflared installation failed."
    exit 1
fi
