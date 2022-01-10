#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd ${HERE}/ubdl
source setenv_py3.sh
source configure.sh

# add to python path
[[ ":$PYTHONPATH:" != *":${HERE}:"* ]] && export PYTHONPATH="${HERE}:${PYTHONPATH}"


