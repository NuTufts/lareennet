#!/bin/bash

# WE NEED TO SETUP ENV VARIABLES FOR ROOT, CUDA, OPENCV
alias python=python3
source /home/gridsan/twongjirad/software/root/bin/thisroot.sh
source /home/gridsan/twongjirad/software/opencv/4.5.3/bin/setup_vars_opencv4.sh
export OPENCV_INCDIR=/home/gridsan/twongjirad/software/opencv/4.5.3/include/opencv4
export OPENCV_LIBDIR=/home/gridsan/twongjirad/software/opencv/4.5.3/lib
export CMAKE_PREFIX_PATH=${OPENCV_LIBDIR}/cmake/opencv4:${CMAKE_PREFIX_PATH}
export CMAKE_PREFIX_PATH=/home/gridsan/twongjirad/software/eigen/3.4.0/share/eigen3/cmake/:${CMAKE_PREFIX_PATH}
