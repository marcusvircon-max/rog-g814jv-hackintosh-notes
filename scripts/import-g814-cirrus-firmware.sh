#!/bin/bash
set -euo pipefail
if [[ $# != 2 ]]; then
    echo "Usage: $0 CIRRUS_SOURCE WINDOWS_CSAUDIOEXT_DRIVERSTORE_DIRECTORY" >&2
    exit 2
fi
source_dir=$(cd "$1" && pwd)
driver_dir=$(cd "$2" && pwd)
playback="$driver_dir/Playback_6.61.1"
wmfw="$playback/Firmware/CS35L41/RevB2/halo_cspl_RAM_revB2_29.63.1.wmfw"
importer="$source_dir/Tools/Firmware/import_firmware.py"
tuning=$(find "$driver_dir" -type d -name ASUS_G814_10431CCF_221125 -print)
if [[ ! -f "$wmfw" || ! -f "$importer" || ! -d "$tuning" ]]; then
    echo "Expected G814JV B2 firmware, tuning directory, or source importer is missing." >&2
    exit 1
fi
cd "$source_dir"
for mode in validate import; do
    validation=()
    if [[ "$mode" == validate ]]; then validation=(--validate-only); fi
    for variant in 0 1; do
        python3 "$importer" ${validation[@]+"${validation[@]}"} \
            --codec cs35l41 --ssid 10431CCF --spkid "$variant" --wmfw "$wmfw" \
            --bin-l "$tuning/10431CCF_221125_V${variant}_A0.bin" \
            --bin-r "$tuning/10431CCF_221125_V${variant}_A1.bin"
    done
done
