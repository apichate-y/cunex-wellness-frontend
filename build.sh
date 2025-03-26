#!/bin/bash

# ติดตั้ง Flutter SDK
git clone https://github.com/flutter/flutter.git -b $FLUTTER_CHANNEL
export PATH="$PATH:`pwd`/flutter/bin"

# ตรวจสอบเวอร์ชัน
flutter --version

# Enable Web
flutter config --enable-web

# Get packages
flutter pub get

# Build web
flutter build web
