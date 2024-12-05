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

        read -p "Introduce el nombre del dispositivo: " DEVICE_NAME

        GH_REPO_PATH=$(calculate_repo_path)

        mkdir -p "${HOME}/.zettelkasten"
        echo "DEVICE_NAME=${DEVICE_NAME}" > "${CONFIG_FILE}"
        echo "GH_REPO_PATH=${GH_REPO_PATH}" >> "${CONFIG_FILE}"

        echo "Configuration file created at ${CONFIG_FILE} with:"
        echo "DEVICE_NAME: ${DEVICE_NAME}"
        echo -e "GH_REPO_PATH: ${GH_REPO_PATH}\n"
    fi
}

confirm() {
    local message="$1"

    read -r -p "$message, seguro? [y/N]: " response

    if [[ "$response" =~ ^([yY])$ ]]; then
        return 0
    else
        echo -e "\nMision abortada"
        return 1
    fi
}

install_merge_tool() {
    mkdir -p "${HOME}/.zettelkasten"

    cp ${SCRIPT_DIR}/my-merge-tool.sh ${HOME}/.zettelkasten
    chmod u+x ${HOME}/.zettelkasten/my-merge-tool.sh

    if ! grep my-merge-tool ${SCRIPT_DIR}/../../.git/config > /dev/null ; then
        cat ${SCRIPT_DIR}/git-config-for-merge >> ${SCRIPT_DIR}/../../.git/config
        echo -e "git-crypt merge tool configured\n"
    else
        echo -e "git-crypt merge tool already configured\n"
    fi
}