#!/bin/bash

cd alice
mkdir /home/overlay_sw
aliBuild build O2Physics --defaults o2 -w /home/overlay_sw 
