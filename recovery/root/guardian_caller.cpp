#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>

// android::sp<IGuardianAngleService> GetGuardianAngleService()
// android::sp<> returns a strong pointer to the service
typedef void* (*GetGuardianAngleServiceFunc)();

// bool IGuardianAngleService::verifyUserPassWord(int user_id, const std::string& password)
// C++ mangled: _ZN7android22BpGuardianAngleService18verifyUserPassWordEiNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE
typedef bool (*VerifyFunc)(void*, int, void*);

// Simple wrapper accessible from C
extern "C" bool guardian_verify_password(int user_id, const char* password) {
    void* handle = dlopen("libGuardianAngleClient.so", RTLD_NOW);
    if (!handle) {
        printf("guardian: dlopen libGuardianAngleClient.so failed: %s\n", dlerror());
        return false;
    }

    auto GetService = (GetGuardianAngleServiceFunc)dlsym(handle, "_Z23GetGuardianAngleServicev");
    if (!GetService) {
        printf("guardian: GetGuardianAngleService not found: %s\n", dlerror());
        dlclose(handle);
        return false;
    }

    void* service = GetService();
    if (!service) {
        printf("guardian: GetGuardianAngleService returned null\n");
        dlclose(handle);
        return false;
    }
    printf("guardian: got GuardianAngleService at %p\n", service);

    // The service is a BpGuardianAngleService which is a Binder proxy
    // verifyUserPassWord(user_id, password_string_16)
    // For simplicity, try calling via the service object's vtable
    // BpGuardianAngleService inherits from BpInterface<IGuardianAngleService>
    // The verify method needs android::String16
    
    // Actually, let's try a simpler approach: 
    // The BpGuardianAngleService::verifyUserPassWord at offset in vtable
    // This is fragile but works for a specific binary
    
    printf("guardian: attempting verifyUserPassWord for user %d...\n", user_id);
    
    // Try calling verify function directly from libGuardianAngleClient
    auto VerifyFunc = (VerifyFunc)dlsym(handle, 
        "_ZN7android22BpGuardianAngleService18verifyUserPassWordEiNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE");
    
    if (VerifyFunc) {
        bool result = VerifyFunc(service, user_id, (void*)password);
        printf("guardian: verifyUserPassWord returned %d\n", result);
        dlclose(handle);
        return result;
    }
    
    printf("guardian: could not find verifyUserPassWord symbol\n");
    dlclose(handle);
    return false;
}
