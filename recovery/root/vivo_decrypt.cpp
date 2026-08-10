#include <dlfcn.h>
#include <string>

static void* vivo_handle = nullptr;
static bool (*vivo_verify)(const std::string&) = nullptr;

bool vivo_gatekeeper_init() {
    vivo_handle = dlopen("libvivogatekeeper.so", RTLD_NOW);
    if (!vivo_handle) return false;

    typedef void (*InitFunc)();
    InitFunc init = (InitFunc)dlsym(vivo_handle, "GateKeeper_init");
    if (init) init();

    vivo_verify = (bool(*)(const std::string&))dlsym(vivo_handle,
        "_ZN16VivoGuardManager14verifyPasswordENSt3__112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE");

    return vivo_verify != nullptr;
}

bool vivo_gatekeeper_verify(const std::string& password) {
    if (!vivo_verify) return false;
    return vivo_verify(password);
}
