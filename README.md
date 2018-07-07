# gdtoa

This is an adaptation of the binary↔decimal floating-point conversion library by David M. Gay to common desktop/server operating systems like Ubuntu and Fedora.

This adapatation's main objective is to provide an easy way to build the original upstream library in the configuration well-suited for the target systems – with locale and multithreading support, and without conflicts with the system libraries like glibc.

## How it compares to the original library

The original library is contained verbatim in the `gdtoa` directory in the root of the source tree. All the adaptations are made using `CMakeLists.txt` and source files outside that directory.

Unlike the `makefile` of the original library, CMake-based build system here enables some options and applies some tweaks:
* `USE_LOCALE`, since any glibc-based apps looking for a compatible parsing and formatting of numbers will need it
* `MULTIPLE_THREADS` + the required locking functions, since the target OSes are multithreaded, and we intend this library to be usable generically.
* All the externally-visible function names have been prefixed by `gdtoa_` prefix. So, if you wanted to call e.g. `g_xfmt(args...)`, you should instead use `gdtoa_g_xfmt(args...)`.

## Installation
Simply doing the following commands should be enough to install the library:
```
mkdir build
cd build
cmake ..
make
make install
```
This will install three files:
```
/usr/local/lib/libgdtoa.so
/usr/local/include/gdtoa/arith.h
/usr/local/include/gdtoa/gdtoa.h
```

## Running tests
After configuring the package using the `cmake` command, run
```
make check
```
This will run tests from the original library.

NOTE: currently 6 tests fail on my x86 system, I'm not sure whether it's OK yet.

## Upgrading to a newer upstream version

If you need to use a newer upstream version of the library, retaining the tweaks made here, and if this repo lags behind, you can upgrade your local copy manually like follows:

1. Remove old `gdtoa/` directory.
1. Extract the new one in its place.
1. Build (but don't install) the library, passing `-DRENAME_FUNCTIONS=OFF` parameter to `cmake`.
1. Use the resulting library `libgdtoa.so` to generate the list of externally-visible functions. You can find the commands for generation in the comments in `rename-functions.sh` and `CMakeLists.txt` (grep for '\<nm\>' there).
1. Having generated the two lists, update them in the corresponding places in these two files.
1. If any new `*.c` files appeared in the original library, add them to `gdtoa_SOURCES` in the `CMakeLists.txt`

Now you should be able to simply build the upgraded library as usual, not forgetting to reset `RENAME_FUNCTIONS` option back to `ON`.
