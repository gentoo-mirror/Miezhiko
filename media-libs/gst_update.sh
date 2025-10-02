#!/bin/bash

NEW_VERSION="1.27.2"

for d in gst*/; do
  cd "$d"
  for f in *.ebuild; do
    OLD_VERSION=$(echo "$f" | sed -r 's/^(.*)-([0-9.]+)\.ebuild$/\2/')
    NEW_NAME=$(echo "$f" | sed -r "s/-$OLD_VERSION\.ebuild/-$NEW_VERSION.ebuild/")
    mv "$f" "$NEW_NAME"
  done
  haku digest
  cd ..
done
