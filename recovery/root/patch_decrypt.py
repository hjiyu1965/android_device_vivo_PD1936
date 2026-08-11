import shutil

path = 'bootable/recovery/crypto/fscrypt/Decrypt.cpp'
shutil.copy(path, path + '.bak')

with open(path, 'r') as f:
    content = f.read()

# 1. Add includes for GuardianAngle Binder IPC
old_include = '#include "Decrypt.h"'
new_include = '''#include "Decrypt.h"
#include <dlfcn.h>
#include <binder/IServiceManager.h>
#include <binder/Parcel.h>
#include <utils/String16.h>'''

assert old_include in content, 'Decrypt.h include not found'
content = content.replace(old_include, new_include, 1)

# 2. Add GuardianAngle verify function before the spblob check
old = '\tif (stat("/data/system_de/0/spblob", &st) == 0) {'

new = '''\t// vivo CE decrypt: call GuardianAngle service via Binder
\t{
\t\tprintf("Vivo FBE decrypt attempt via GuardianAngle...\\n");
\t\tvoid* binder_handle = dlopen("libbinder.so", RTLD_NOW);
\t\tif (binder_handle) {
\t\t\ttypedef void* (*GetSMFunc)();
\t\t\tGetSMFunc getSM = (GetSMFunc)dlsym(binder_handle, "_ZN7android21defaultServiceManagerEv");
\t\t\tif (getSM) {
\t\t\t\tvoid* sm = getSM();
\t\t\t\tif (sm) {
\t\t\t\t\ttypedef void* (*GetSvcFunc)(void*, const android::String16&);
\t\t\t\t\tGetSvcFunc getSvc = (GetSvcFunc)dlsym(binder_handle, "_ZN7android14IServiceManager10getServiceERKNS_8String16E");
\t\t\t\t\tif (getSvc) {
\t\t\t\t\t\tvoid* binder = getSvc(sm, android::String16("GuardianAngleService"));
\t\t\t\t\t\tif (binder) {
\t\t\t\t\t\t\tprintf("guardian: got GuardianAngleService binder\\n");
\t\t\t\t\t\t\t// Call transact(1) = verifyUserPassWord
\t\t\t\t\t\t\tandroid::Parcel data, reply;
\t\t\t\t\t\t\tdata.writeInterfaceToken(android::String16("android.IGuardianAngleService"));
\t\t\t\t\t\t\tdata.writeInt32(user_id);
\t\t\t\t\t\t\tdata.writeString16(android::String16(Password.c_str()));
\t\t\t\t\t\t\ttypedef int (*TransactFunc)(void*, uint32_t, const android::Parcel&, android::Parcel*, uint32_t);
\t\t\t\t\t\t\tTransactFunc transact = (TransactFunc)dlsym(binder_handle, "_ZN7android7BBinder8transactEjRKNS_6ParcelEPS1_j");
\t\t\t\t\t\t\tstatus_t status = ((BBinder*)binder.data.get())->transact(1, data, &reply, 0);
\t\t\t\t\t\t\tif (status == 0) {
\t\t\t\t\t\t\t\tbool result = reply.readBool();
\t\t\t\t\t\t\t\tprintf("guardian: verifyUserPassWord returned %d\\n", result);
\t\t\t\t\t\t\t\tif (result) {
\t\t\t\t\t\t\t\t\tdlclose(binder_handle);
\t\t\t\t\t\t\t\t\treturn true;
\t\t\t\t\t\t\t\t}
\t\t\t\t\t\t\t} else {
\t\t\t\t\t\t\t\tprintf("guardian: transact failed: %d\\n", status);
\t\t\t\t\t\t\t}
\t\t\t\t\t\t} else {
\t\t\t\t\t\t\tprintf("guardian: GuardianAngleService not found\\n");
\t\t\t\t\t\t}
\t\t\t\t\t} else {
\t\t\t\t\t\tprintf("guardian: getService symbol not found\\n");
\t\t\t\t\t}
\t\t\t\t} else {
\t\t\t\t\tprintf("guardian: defaultServiceManager returned null\\n");
\t\t\t\t}
\t\t\t} else {
\t\t\t\tprintf("guardian: defaultServiceManager symbol not found\\n");
\t\t\t}
\t\t\tdlclose(binder_handle);
\t\t} else {
\t\t\tprintf("guardian: dlopen libbinder failed: %s\\n", dlerror());
\t\t}
\t\tprintf("guardian: falling back to standard decrypt\\n");
\t}

''' + old

assert old in content, 'spblob check not found in Decrypt.cpp'
content = content.replace(old, new, 1)

with open(path, 'w') as f:
    f.write(content)

print('Decrypt.cpp patched for vivo GuardianAngle CE decrypt (inline Binder)')
