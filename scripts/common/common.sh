#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/repo.conf"

pause() {
    read -p $'\npress any key to exit\n' -n 1 -s
}

load_device_config() {
    CONFIG_FILE="${HOME}/.zettelkasten/device.conf"

    if [ -f "${CONFIG_FILE}" ]; then
        source "${CONFIG_FILE}"
        echo "Configuration sourced from ${CONFIG_FILE} with:"
        echo "DEVICE_NAME: ${DEVICE_NAME}"
        echo -e "GH_REPO_PATH: ${GH_REPO_PATH}\n"
    else
        calculate_repo_path() {
            GH_REPO_PATH=""

            if [[ "${SCRIPT_DIR}" == *"$GH_REPO_NAME"* ]]; then
                GH_REPO_PATH="${SCRIPT_DIR%%$GH_REPO_NAME*}${GH_REPO_NAME}"
                echo "${GH_REPO_PATH}"
            else
                echo "Error: Unable to locate the repository path."
                exit 1
            fi
        }

        read -p "Enter the name of the device: " DEVICE_NAME

        GH_REPO_PATH=$(calculate_repo_path)

        mkdir -p "${HOME}/.zettelkasten"
        echo "DEVICE_NAME=${DEVICE_NAME}" > "${CONFIG_FILE}"
        echo "GH_REPO_PATH=${GH_REPO_PATH}" >> "${CONFIG_FILE}"

        echo "Configuration file created at ${CONFIG_FILE} with:"
        echo "DEVICE_NAME: ${DEVICE_NAME}"
        echo -e "GH_REPO_PATH: ${GH_REPO_PATH}\n"
    fi
}