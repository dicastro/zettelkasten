#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/common/common.sh"

load_device_config

install_merge_tool

pushd ${GH_REPO_PATH} > /dev/null 2>&1

echo -e "Fetching remote changes...\n"
git fetch origin main

LAST_REMOTE_COMMIT_MSG=$(git log origin/main -1 --pretty=%B)

if [[ "$LAST_REMOTE_COMMIT_MSG" == "primer commit despues de borrar historico"* ]]; then
    echo -e "Detected history reset in the repository. Performing a hard reset...\n"
    git reset --hard origin/main
else
    echo -e "\nNo history reset detected. Pulling changes...\n"
    git pull
fi

popd > /dev/null 2>&1

pause