#!/usr/env bash

find ~/workspace/TanandaOS-23 -type f -exec sed -i -r 's/(\@critical-path-gnome.*)/#\1/g' {} \; 

