#!/bin/bash

set -e

CLIENTBUFFER_PARENT="/usr/local/src"
CLIENTBUFFER_DIR="${CLIENTBUFFER_PARENT}/znc-clientbuffer"
CLIENTBUFFER_DPKG_VERSION_FILE="${CLIENTBUFFER_PARENT}/znc-clientbuffer-version.txt"
EXISTING_ZNC_VERSION=

if [[ -f ${CLIENTBUFFER_DPKG_VERSION_FILE} ]]
then
    EXISTING_ZNC_VERSION="$(<${CLIENTBUFFER_DPKG_VERSION_FILE})"
fi

NEW_ZNC_VERSION="$(dpkg -s znc-dev | grep '^Version: ')"
NEW_ZNC_VERSION="${NEW_ZNC_VERSION#Version: }"

if [[ "${EXISTING_ZNC_VERSION}" != "${NEW_ZNC_VERSION}" ]]
then
    echo "Rebuilding znc-clientbuffer as znc-dev version has changed from [${EXISTING_ZNC_VERSION}] to [${NEW_ZNC_VERSION}]."
    cd "${CLIENTBUFFER_DIR}"
    git checkout master
    git reset
    git clean -d -f -x
    git fetch origin
    git reset --hard origin/master
    make install PREFIX=/usr
    echo "${NEW_ZNC_VERSION}" > "${CLIENTBUFFER_DPKG_VERSION_FILE}"
fi
