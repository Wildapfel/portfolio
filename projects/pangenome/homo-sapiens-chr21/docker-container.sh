#!/usr/bin/bash

podman run \
    -it \
    -v $(pwd):/mnt:z \
    localhost/pangenome-workflow:latest \
    bash
