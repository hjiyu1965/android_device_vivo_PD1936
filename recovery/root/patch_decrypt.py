import shutil

path = 'bootable/recovery/crypto/fscrypt/Decrypt.cpp'
shutil.copy(path, path + '.bak')

with open(path, 'r') as f:
    content = f.read()

old = '\tif (stat(filename.c_str(), &st) != 0) {'

new = '''\t// vivo CE decrypt: use wrapper that swaps fstab for vivofbe
\tprintf("Vivo FBE decrypt attempt via vivofbe_wrapper...\\n");
\tchar vivocmd[256];
\tsnprintf(vivocmd, sizeof(vivocmd), "/system/bin/vivofbe_wrapper %d '%s'", user_id, Password.c_str());
\tif (system(vivocmd) == 0) {
\t\tprintf("vivofbe returned success\\n");
\t\treturn true;
\t}
\tprintf("vivofbe failed, trying TWRP standard method\\n");
''' + old

assert old in content, 'Decrypt_User gatekeeper path not found'
content = content.replace(old, new, 1)

with open(path, 'w') as f:
    f.write(content)

print('Decrypt.cpp patched for vivo vivofbe fallback')
