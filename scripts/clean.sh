#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/common/common.sh"

load_device_config

install_merge_tool

if confirm "A punto de limpiar historico de git y directorio bak de logseq"; then
    pushd ${GH_REPO_PATH} > /dev/null 2>&1
    
    rm -Rf logseqdb/logseq/bak

    GIT_CONFIG_FOLDER=".git"
    GIT_CONFIG_FILE="${GIT_CONFIG_FOLDER}/config"
    GIT_CRYPT_FOLDER="${GIT_CONFIG_FOLDER}/git-crypt"

    if [ -f "${GIT_CONFIG_FILE}" ]; then
        TEMP_BACKUP_DIR=$(mktemp -d)
        echo -e "\nCreated temporary dir to backup git configuration: ${TEMP_BACKUP_DIR}\n"

        echo -e "Backing up git config file...\n"
        cp ${GIT_CONFIG_FILE} ${TEMP_BACKUP_DIR}

        if [ -d "${GIT_CRYPT_FOLDER}" ]; then
            echo -e "Backing up git-crypt config folder...\n"
            cp -R ${GIT_CRYPT_FOLDER} ${TEMP_BACKUP_DIR}
        fi

        echo -e "Destroying git repo...\n"
        rm -Rf .git
        
        echo -e "Initializing git repo...\n"
        git init .

        echo -e "\nRestoring git config file...\n"
        cp ${TEMP_BACKUP_DIR}/config ${GIT_CONFIG_FOLDER}

        echo -e "Restoring git-crypt config folder...\n"
        cp -R ${TEMP_BACKUP_DIR}/git-crypt ${GIT_CONFIG_FOLDER}

        echo -e "Adding files to commit...\n"
        git add .

        echo -e "Commiting files...\n"
        git commit -m "primer commit despues de borrar historico desde ${DEVICE_NAME}"

        echo -e "\nPushing...\n"
        git branch -M main
        git push -f origin main

        echo -e "\nRemoving temporary backup folder...\n"
        rm -Rf ${TEMP_BACKUP_DIR}
    else
        echo "\nWARN: No git config file found. Aborting...\n"
    fi

    popd > /dev/null 2>&1
fi

pause
