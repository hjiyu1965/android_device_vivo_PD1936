#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Minimal GuardianAngle client using dlopen
// Avoids needing Android Binder/Parcel headers

int main(int argc, char* argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <user_id> <password>\n", argv[0]);
        return 1;
    }
    int userId = atoi(argv[1]);
    const char* password = argv[2];

    void* h = dlopen("libGuardianAngleClient.so", RTLD_NOW);
    if (!h) { printf("guardian: dlopen failed: %s\n", dlerror()); return 1; }

    typedef void* (*GetSvcFunc)();
    GetSvcFunc getSvc = (GetSvcFunc)dlsym(h, "_Z23GetGuardianAngleServicev");
    if (!getSvc) { printf("guardian: GetGuardianAngleService not found\n"); dlclose(h); return 1; }

    void* service = getSvc();
    if (!service) { printf("guardian: null service\n"); dlclose(h); return 1; }
    printf("guardian: got service %p, calling verify via vtable...\n", service);

    // sp<IGuardianAngleService> is a BpInterface<IGuardianAngleService>
    // The service pointer points to BpGuardianAngleService which has:
    // offset 0: sp<IBinder> mRemote  (8 bytes on 64-bit)
    // After the sp, we have the BpGuardianAngleService vtable
    // Try calling verifyUserPassWord through Binder transact
    
    // Get the binder object from the smart pointer
    void** ptr = *(void***)service;  // deref sp to get BpRefBase
    void* binder = ptr[0];           // sp<IBinder> mRemote
    
    // Now call transact on binder to send verifyUserPassWord
    // verifyUserPassWord has transaction code 1
    // We need to send: interfaceToken (String16) + userId (int32) + password (String16)
    
    printf("guardian: got binder %p\n", binder);
    
    // Just try calling verify directly via the mangled name
    typedef bool (*VerifyFunc)(void*, int, void*);
    void* vh = dlopen("libGuardianAngleService.so", RTLD_NOW);
    if (vh) {
        VerifyFunc vf = (VerifyFunc)dlsym(vh, "_ZN7android22BpGuardianAngleService18verifyUserPassWordEiNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE");
        if (vf) {
            // Need to construct a std::string from password
            // std::string has: pointer, size, capacity (or SSO buffer)
            char pwd_str[64];
            snprintf(pwd_str, sizeof(pwd_str), "%s", password);
            
            struct { char* ptr; size_t size; union { char buf[16]; size_t cap; }; } str;
            str.ptr = pwd_str;
            str.size = strlen(password);
            str.cap = 15; // small string mode
            
            printf("guardian: calling verifyUserPassWord(%d, '%s')...\n", userId, password);
            bool ok = vf(service, userId, &str);
            printf("guardian: verifyUserPassWord = %d\n", ok);
            dlclose(vh); dlclose(h);
            return ok ? 0 : 1;
        }
        dlclose(vh);
    }
    
    dlclose(h);
    printf("guardian: verify function not available\n");
    return 1;
}
