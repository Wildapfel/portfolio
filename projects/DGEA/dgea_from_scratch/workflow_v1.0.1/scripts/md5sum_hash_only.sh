#!/usr/bin/bash

# 
# Simply filter first element with awk and print
# 
file=$1
md5sum $file | awk '{ print $1 }'