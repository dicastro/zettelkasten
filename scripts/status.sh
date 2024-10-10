#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/common/common.sh"

load_device_config

pushd ${GH_REPO_PATH}
git status
popd

pause