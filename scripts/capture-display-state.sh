#!/bin/bash
set -euo pipefail

printf 'Timestamp: %s\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')"
printf '\n== macOS online displays ==\n'
system_profiler SPDisplaysDataType | awk '!/Serial Number:/'
printf '\n== NullMoth display services ==\n'
for service in NVRMDisplay NVRMNVDAFramebuffer; do
    ioreg -r -c "$service" -d 1 -w0 | awk '
        /class NVRMDisplay,|class NVRMNVDAFramebuffer,/ {print}
        /"(connected-displays|IOFBCurrentPixelCount|IOFBCurrentPixelClock|NVRMFBDisplayAudioPhysicalIndex|NVRMFBDisplayAudioProbe)"/ {print}
    '
done
printf '\n== Thunderbolt / USB4 ==\n'
system_profiler SPThunderboltDataType | awk '!/Serial Number:|UID:/'
