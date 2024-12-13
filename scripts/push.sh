#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/common/common.sh"

load_device_config

install_merge_tool

pushd ${GH_REPO_PATH} > /dev/null 2>&1
echo -e "Cleanin bak folder...\n"
git clean -fd logseqdb/logseq/bak/

echo -e "Adding files to commit...\n"
git add .

echo -e "Commiting files...\n"
git commit -m "cambios desde ${DEVICE_NAME}"

echo -e "\nPushing...\n"
git push
popd > /dev/null 2>&1

pause
