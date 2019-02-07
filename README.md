This is a dockerized build environment for the
[Retron 77 firmware](https://github.com/DirtyHairy/r77-firmware-ng).

Doing `docker build` will give you a build container based on Debian Stretch,
with all required tools installed and the toolchain set up. The repository
is not mounted, but instead checkout out inside the container. This is done
on purpose as my development system is a Mac and I Docker for Mac's I/O
performance would make building the 1GB+ file tree a pain.

If you simply want to build the firmware, simply start a container based
on the built image, check out the desired branch or tag and do `make`.
Note that the final build step (creating
the SD card image) will fail unless you run the container in privileged mode
(`docker run --privileged`). However, the `uImage` is created even without
privileged mode.
