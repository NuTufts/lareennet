#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source /usr/local/root/bin/thisroot.sh
export CUDA_HOME=/usr/local/cuda/
[[ ":$LD_LIBRARY_PATH:" != *":${CUDA_HOME}/lib64:"* ]] && export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"

export OPENCV_INCDIR=/usr/include
export OPENCV_LIBDIR=/usr/local/lib

cd /usr/local/ubdl
source configure.sh

# add to python path
cd ${HERE}
[[ ":$PYTHONPATH:" != *":${HERE}:"* ]] && export PYTHONPATH="${HERE}:${PYTHONPATH}"


