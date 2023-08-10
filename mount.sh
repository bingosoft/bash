#!/usr/bin/env bash

# sudo port install ntfs-3g
# diskutil list

sudo ntfs-3g /dev/disk2s2 /Volumes/Bingo\ HDD/ -olocal -oallow_other -o auto_xattr
