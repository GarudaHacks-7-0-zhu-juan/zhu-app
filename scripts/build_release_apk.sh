#!/usr/bin/env bash

set -euo pipefail

readonly project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly key_properties="$project_root/android/key.properties"
readonly apk="$project_root/build/app/outputs/flutter-apk/app-release.apk"
readonly dist_dir="$project_root/dist"

cd "$project_root"

if ! command -v fvm >/dev/null 2>&1; then
  printf '%s\n' 'Error: FVM is required. Install FVM, then run make setup.' >&2
  exit 1
fi

if [[ ! -f "$key_properties" ]]; then
  printf '%s\n' \
    'Error: android/key.properties is missing.' \
    'Copy android/key.properties.example to android/key.properties and configure it.' >&2
  exit 1
fi

for property in storePassword keyPassword keyAlias storeFile; do
  if ! grep -Eq "^[[:space:]]*${property}[[:space:]]*=[[:space:]]*[^[:space:]].*$" "$key_properties"; then
    printf 'Error: %s is missing or empty in android/key.properties.\n' "$property" >&2
    exit 1
  fi
done

store_file="$(sed -n 's/^[[:space:]]*storeFile[[:space:]]*=[[:space:]]*//p' "$key_properties" | tr -d '\r' | sed -n '1p')"
if [[ "$store_file" != /* ]]; then
  store_file="$project_root/android/app/$store_file"
fi
if [[ ! -f "$store_file" ]]; then
  printf 'Error: signing keystore not found: %s\n' "$store_file" >&2
  exit 1
fi

printf '%s\n' 'Building signed ProtectMe release APK...'
fvm flutter build apk --release "$@"

if [[ ! -f "$apk" ]]; then
  printf 'Error: Flutter build completed but APK was not found: %s\n' "$apk" >&2
  exit 1
fi

version="$(sed -n 's/^version:[[:space:]]*//p' pubspec.yaml | tr -d '\r' | tr '+/' '--' | sed -n '1p')"
if [[ -z "$version" ]]; then
  printf '%s\n' 'Error: could not read app version from pubspec.yaml.' >&2
  exit 1
fi

mkdir -p "$dist_dir"
artifact="$dist_dir/ProtectMe-${version}-release.apk"
cp "$apk" "$artifact"

printf '\n%s\n' "APK ready: $artifact"
printf '%s\n' 'Share this APK file with your friend. Keep the signing keystore for future updates.'
