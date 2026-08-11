#include <android/IBinder.h>
#include <binder/IServiceManager.h>
#include <utils/String16.h>
#include <utils/String8.h>
#include <stdio.h>
#include <stdlib.h>

using namespace android;

// Interface descriptor for IGuardianAngleService
// Defined in libGuardianAngleService.so
static const char* kServiceName = "GuardianAngleService";
static const char* kInterfaceDesc = "android.IGuardianAngleService";

class BpGuardianAngleService : public BpInterface<IInterface> {
public:
    explicit BpGuardianAngleService(const sp<IBinder>& impl)
        : BpInterface<IInterface>(impl) {}

    bool verifyUserPassWord(int32_t userId, const String16& password) {
        Parcel data, reply;
        data.writeInterfaceToken(String16(kInterfaceDesc));
        data.writeInt32(userId);
        data.writeString16(password);
        status_t status = remote()->transact(1, data, &reply);
        if (status != NO_ERROR) {
            printf("guardian: transact failed: %d\n", status);
            return false;
        }
        bool result = reply.readBool();
        printf("guardian: verifyUserPassWord returned %d\n", result);
        return result;
    }
};

int main(int argc, char* argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <user_id> <password>\n", argv[0]);
        return 1;
    }

    int userId = atoi(argv[1]);
    const char* password = argv[2];

    printf("guardian: getting service '%s'...\n", kServiceName);

    sp<IServiceManager> sm = defaultServiceManager();
    if (sm == nullptr) {
        fprintf(stderr, "guardian: failed to get ServiceManager\n");
        return 1;
    }

    sp<IBinder> binder = sm->getService(String16(kServiceName));
    if (binder == nullptr) {
        fprintf(stderr, "guardian: service '%s' not found\n", kServiceName);
        return 1;
    }

    printf("guardian: got binder for '%s'\n", kServiceName);

    BpGuardianAngleService service(binder);

    String16 password16(password);
    return service.verifyUserPassWord(userId, password16) ? 0 : 1;
}
