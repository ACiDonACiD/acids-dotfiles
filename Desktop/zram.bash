#!/bin/bash

echo lz4 > /sys/block/zram0/comp_algorithm
echo $((2 * 1024 * 1024 * 1024)) > /sys/block/zram0/disksize

mkswap /dev/zram0
swapon /dev/zram0
