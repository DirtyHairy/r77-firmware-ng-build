This is a dockerized build environment for the
[Retron 77 firmware](https://github.com/DirtyHairy/r77-firmware-ng). The image
contains a checkout of the firmware together with all tools required for
building. To do a release build of the latest firmware version, start a container
and then do

```
$ git pull
$ git submodule update
$ make RELEASE=1
```

Note that the last step (building the SD card image) will fail unless you start the
container as `--privileged`.

You can pull the prebuilt environment for arm64 and amd64 from
`cnspeckn/r77-firmware-ng-build:latest`. Although the image is available for arm64,
the build process itself relies on propietary binary tools from Allwinner, so
the docker host needs to have binfmt / qemu support for executing x86_64
binaries. This works seemlessly on Docker desktop for Mac or Windows, but on Linux
you'll have to do the necessary setup yourself.
