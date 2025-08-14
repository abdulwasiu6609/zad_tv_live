#!/bin/bash
set -e

# Location for Flutter SDK in Vercel cache
FLUTTER_DIR=".vercel_cache/flutter"

# Install Flutter if not cached
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "⬇️ Installing Flutter SDK..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$FLUTTER_DIR"
else
  echo "✅ Using cached Flutter SDK"
fi

# Add Flutter to PATH
export PATH="$PATH:$(pwd)/$FLUTTER_DIR/bin"

# Check version
flutter --version

# Install dependencies
flutter pub get

# Build web release
flutter build web --release
