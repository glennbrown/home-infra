#!/bin/bash
set -e

PALAVER_PARENT="/usr/local/src"
PALAVER_DIR="${PALAVER_PARENT}/znc-palaver"
PALAVER_DPKG_VERSION_FILE="${PALAVER_PARENT}/znc-palaver-version.txt"
EXISTING_ZNC_VERSION=

if [[ -f ${PALAVER_DPKG_VERSION_FILE} ]]
then
    EXISTING_ZNC_VERSION="$(<${PALAVER_DPKG_VERSION_FILE})"
fi

NEW_ZNC_VERSION="$(dpkg -s znc-dev | grep '^Version: ')"
NEW_ZNC_VERSION="${NEW_ZNC_VERSION#Version: }"

if [[ "${EXISTING_ZNC_VERSION}" != "${NEW_ZNC_VERSION}" ]]
then
    echo "Rebuilding znc-palaver as znc-dev version has changed from [${EXISTING_ZNC_VERSION}] to [${NEW_ZNC_VERSION}]."
    cd "${PALAVER_DIR}"
    git checkout master
    git reset
    git clean -d -f -x
    git fetch origin
    git reset --hard origin/master
    znc-buildmod palaver.cpp
    cp palaver.so /usr/lib/znc
    echo "${NEW_ZNC_VERSION}" > "${PALAVER_DPKG_VERSION_FILE}"
fi