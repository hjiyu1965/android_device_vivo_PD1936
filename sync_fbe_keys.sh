#!/bin/bash
# sync_fbe_keys.sh — copy decrypted vivo FBE user keys for TWRP
#
# The stock user_keys dir is self-encrypted (vivo savior design), so TWRP
# reads plaintext copies from /data/unencrypted/user_keys instead. This
# script refreshes those copies from a rooted, unlocked stock system.
#
# Run this:
#   1. after every lockscreen PIN/password change
#   2. after system OTA updates
#
# Requirements: phone booted to the STOCK system, screen unlocked
# (enter the PIN once), adb authorized, root (su) available.

set -e
ADB=${ADB:-adb}
echo "[*] Waiting for device..."
$ADB wait-for-device

echo "[*] Checking CE unlock state..."
STATE=$($ADB shell 'getprop sys.user.0.ce_available' | tr -d '\r')
if [ "$STATE" != "true" ]; then
    echo "[-] CE storage is still locked. Unlock the phone screen (enter your PIN) and re-run."
    exit 1
fi
echo "[+] CE unlocked."

echo "[*] Checking root..."
$ADB shell 'su -c id' | grep -q 'uid=0' || {
    echo "[-] su not available or not root. Check your root manager."
    exit 1
}
echo "[+] Root OK."

echo "[*] Copying decrypted user keys to /data/unencrypted/user_keys ..."
$ADB shell 'su -c "mkdir -p /data/unencrypted/user_keys && rm -rf /data/unencrypted/user_keys/ce /data/unencrypted/user_keys/de && cp -a /data/misc/vold/user_keys/ce /data/misc/vold/user_keys/de /data/unencrypted/user_keys/ && chmod -R 700 /data/unencrypted/user_keys"'

echo "[*] Verifying copies..."
for f in ce/0/current de/0; do
    V=$($ADB shell "su -c 'cat /data/unencrypted/user_keys/$f/version'" | tr -d '\r\n')
    if [ "$V" != "1" ]; then
        echo "[-] VERIFY FAILED: /data/unencrypted/user_keys/$f/version = '$V' (expected 1)"
        echo "    The key files are not in standard format. Report this to the maintainer."
        exit 1
    fi
done
echo "[+] Keys synced successfully."
echo ""
echo "    Reboot to TWRP:  adb reboot recovery"
echo "    (TWRP will auto-decrypt /data at boot.)"
