This is a dockerized build environment for the [Retron 77
firmware](https://github.com/DirtyHairy/r77-firmware-ng). The image contains a
checkout of the firmware together with all tools required for building. In order
to do a release build, start the container and run

```
$ git pull
§ git submodule update
$ make RELEASE=1
```

Including `RELEASE=1` will build Stella with PGO (profile guided optimisation).
This gives a considerable speed boost at the expense of increased build time.
The last build step (creating the SD card image) will fail unless the container
is started as `--privileged`, but the `uImage` will be created and can be used
in any case.

You can pull the prebuilt environment for arm64 and amd64 from
`cnspeckn/r77-firmware-ng-build:latest`. Although the image is available for arm64,
the build process itself relies on propietary binary tools from Allwinner, so
the docker host needs to have `binfmt_misc` / `qemu-user` set up for executing x86_64
binaries. This works seemlessly on Docker desktop for Mac or Windows, but on Linux
you'll have to do the necessary setup yourself.
