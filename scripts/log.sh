#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/common/common.sh"

load_device_config

install_merge_tool

pushd ${GH_REPO_PATH}
git log --date=format:"%d/%m/%Y %H:%M:%S"
popd

pause