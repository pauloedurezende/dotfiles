#!/usr/bin/env bash
case "$(uname -s)" in
  Darwin) afplay /System/Library/Sounds/Glass.aiff & ;;
  Linux)  paplay /usr/share/sounds/freedesktop/stereo/complete.oga & ;;
esac
exit 0
