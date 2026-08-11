import shutil

path = 'bootable/recovery/crypto/fscrypt/Decrypt.cpp'
shutil.copy(path, path + '.bak')

with open(path, 'r') as f:
    content = f.read()

old = '\tif (stat(filename.c_str(), &st) != 0) {'

new = '''\t// vivo CE decrypt: use GuardianAngle service via gadecrypt
\tprintf("Vivo FBE decrypt attempt via gadecrypt...\\n");
\tchar vivocmd[256];
\tsnprintf(vivocmd, sizeof(vivocmd), "/system/bin/gadecrypt %d '%s'", user_id, Password.c_str());
\tif (system(vivocmd) == 0) {
\t\tprintf("gadecrypt returned success\\n");
\t\treturn true;
\t}
\tprintf("gadecrypt failed, trying TWRP standard method\\n");
''' + old

assert old in content, 'Decrypt_User gatekeeper path not found'
content = content.replace(old, new, 1)

with open(path, 'w') as f:
    f.write(content)

print('Decrypt.cpp patched for vivo vivofbe fallback')
