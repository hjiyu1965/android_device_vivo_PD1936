#!/system/bin/sh
# vivo PD1936: auto-sync FBE user keys for TWRP (runs as a Magisk/APatch
# module service.sh at late boot, after CE unlock).
DEST=/data/unencrypted/user_keys
SRC=/data/misc/vold/user_keys

i=0
V=""
while [ $i -lt 12 ]; do
    V=$(cat "$SRC/de/0/version" 2>/dev/null)
    [ "$V" = "1" ] && break
    sleep 5
    i=$((i+1))
done
if [ "$V" != "1" ]; then
    echo "fbe-sync: keys not standard yet (locked?), skipping" > /dev/kmsg
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
