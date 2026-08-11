#include <binder/IServiceManager.h>
#include <binder/Parcel.h>
#include <utils/String16.h>
#include <stdio.h>
#include <stdlib.h>

using namespace android;

// Declared in libGuardianAngleClient.so
extern "C" sp<IBinder> _Z23GetGuardianAngleServicev();

int main(int argc, char* argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <user_id> <password>\n", argv[0]);
        return 1;
    }
    int userId = atoi(argv[1]);
    const char* password = argv[2];

    printf("guardian: getting GuardianAngle service...\n");
    sp<IBinder> binder = _Z23GetGuardianAngleServicev();
    if (binder == nullptr) {
        fprintf(stderr, "guardian: GetGuardianAngleService returned null\n");
        return 1;
    }

    Parcel data, reply;
    data.writeInterfaceToken(String16("android.IGuardianAngleService"));
    data.writeInt32(userId);
    data.writeString16(String16(password));

    printf("guardian: calling verifyUserPassWord(%d, '%s')...\n", userId, password);
    status_t status = binder->transact(1, data, &reply);
    if (status != NO_ERROR) {
        fprintf(stderr, "guardian: transact failed: %d\n", status);
        return 1;
    }

    bool result = reply.readBool();
    printf("guardian: verifyUserPassWord = %d\n", result);
    return result ? 0 : 1;
}
