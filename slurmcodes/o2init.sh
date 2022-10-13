#!/bin/sh

cd alice
aliBuild init O2@dev --defaults o2
aliBuild init O2Physics@master --defaults o2
aliDoctor O2Physics --defaults o2
