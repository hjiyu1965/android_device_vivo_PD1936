#!/system/bin/sh
# vivo PD1936: auto-sync FBE user keys for TWRP
#
# The stock user_keys dir is self-encrypted (vivo savior design), so TWRP
# reads plaintext copies from /data/unencrypted/user_keys. This script
# refreshes those copies on every boot, so TWRP can decrypt /data without
# any manual step (as long as the phone booted into the system once and the
# screen was unlocked).
#
# Runs as root from Magisk service.d at boot completion (CE already
# unlocked by then).
DEST=/data/unencrypted/user_keys
SRC=/data/misc/vold/user_keys

i=0
while [ $i -lt 12 ]; do
    V=$(cat "$SRC/de/0/version" 2>/dev/null)
    [ "$V" = "1" ] && break
    sleep 5
    i=$((i+1))
done
if [ "$V" != "1" ]; then
    echo "fbe-sync: keys not in standard format yet (locked?), skipping" > /dev/kmsg
    exit 0
fi

rm -rf "$DEST/ce" "$DEST/de"
mkdir -p "$DEST"
if cp -a "$SRC/ce" "$SRC/de" "$DEST/"; then
    chmod -R 700 "$DEST"
    echo "fbe-sync: copied decrypted user keys for TWRP" > /dev/kmsg
else
    echo "fbe-sync: copy failed" > /dev/kmsg
fi
