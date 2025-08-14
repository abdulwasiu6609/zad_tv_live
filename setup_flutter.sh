#!/bin/bash

# Location in Vercel's cache for Flutter SDK
FLUTTER_DIR=".vercel_cache/flutter"

# If Flutter is already cached, use it
if [ -d "$FLUTTER_DIR" ]; then
  echo "✅ Using cached Flutter SDK"
else
  echo "⬇️ Installing Flutter SDK..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$FLUTTER_DIR"
fi

# Add Flutter to PATH
export PATH="$PATH:`pwd`/$FLUTTER_DIR/bin"

# Check Flutter version
flutter --version

# Get project dependencies
flutter pub get
