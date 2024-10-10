#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/common/common.sh"

load_device_config

pushd ${GH_REPO_PATH} > /dev/null 2>&1
echo -e "Pulling...\n"
git pull
popd > /dev/null 2>&1

pause