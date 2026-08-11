import shutil

path = 'bootable/recovery/crypto/fscrypt/Decrypt.cpp'
shutil.copy(path, path + '.bak')

with open(path, 'r') as f:
    content = f.read()

# Add Binder include
old_inc = '#include "Decrypt.h"'
new_inc = '''#include "Decrypt.h"
#include <binder/IServiceManager.h>
#include <binder/Parcel.h>
#include <utils/String16.h>'''
assert old_inc in content, 'Decrypt.h include not found'
content = content.replace(old_inc, new_inc, 1)

# Add GuardianAngle call before spblob check
old = '\tif (stat("/data/system_de/0/spblob", &st) == 0) {'

new = '''\t// vivo CE decrypt: call GuardianAngle Binder service directly
\t{
\t\tprintf("Vivo FBE decrypt: calling GuardianAngle...\\n");
\t\tandroid::sp<android::IServiceManager> sm = android::defaultServiceManager();
\t\tif (sm != nullptr) {
\t\t\tandroid::sp<android::IBinder> binder = sm->getService(android::String16("GuardianAngleService"));
\t\t\tif (binder != nullptr) {
\t\t\t\tandroid::Parcel data, reply;
\t\t\t\tdata.writeInterfaceToken(android::String16("android.IGuardianAngleService"));
\t\t\t\tdata.writeInt32(user_id);
\t\t\t\tdata.writeString16(android::String16(Password.c_str()));
\t\t\t\tandroid::status_t status = binder->transact(1, data, &reply);
\t\t\t\tif (status == android::NO_ERROR) {
\t\t\t\t\tbool result = reply.readBool();
\t\t\t\t\tprintf("guardian: verifyUserPassWord = %d\\n", result);
\t\t\t\t\tif (result) return true;
\t\t\t\t} else {
\t\t\t\t\tprintf("guardian: transact failed: %d\\n", status);
\t\t\t\t}
\t\t\t} else {
\t\t\t\tprintf("guardian: GuardianAngleService not found\\n");
\t\t\t}
\t\t} else {
\t\t\tprintf("guardian: ServiceManager not available\\n");
\t\t}
\t\tprintf("guardian: falling back to standard decrypt\\n");
\t}

''' + old

assert old in content, 'spblob check not found in Decrypt.cpp'
content = content.replace(old, new, 1)

with open(path, 'w') as f:
    f.write(content)

print('Decrypt.cpp patched with inline GuardianAngle Binder call')
