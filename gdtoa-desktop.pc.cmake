prefix=@CMAKE_INSTALL_PREFIX@
libdir=@CMAKE_INSTALL_PREFIX@/@CMAKE_INSTALL_LIBDIR@
includedir=@CMAKE_INSTALL_PREFIX@/@CMAKE_INSTALL_INCLUDEDIR@

Name: gdtoa-desktop
Description: Binary↔decimal floating-point conversion library
Version: @PROJECT_VERSION@

Libs: -L${libdir} -lgdtoa-desktop
Cflags: -I${includedir}/gdtoa-desktop
