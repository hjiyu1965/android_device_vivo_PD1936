import shutil

path = 'bootable/recovery/crypto/fscrypt/Decrypt.cpp'
shutil.copy(path, path + '.bak')

with open(path, 'r') as f:
    content = f.read()

old = '\tif (stat("/data/system_de/0/spblob", &st) == 0) {'

new = '''\t// vivo CE decrypt: call gadecrypt (GuardianAngle Binder client)
\tprintf("Vivo FBE decrypt attempt via gadecrypt...\\n");
\tchar gacmd[256];
\tsnprintf(gacmd, sizeof(gacmd), "/system/bin/gadecrypt %d '%s'", user_id, Password.c_str());
\tif (system(gacmd) == 0) {
\t\tprintf("gadecrypt returned success\\n");
\t\treturn true;
\t}
\tprintf("gadecrypt failed, trying standard methods\\n");
''' + old

assert old in content, 'spblob check not found in Decrypt.cpp'
content = content.replace(old, new, 1)

with open(path, 'w') as f:
    f.write(content)

print('Decrypt.cpp patched for vivo CE decrypt via gadecrypt')
