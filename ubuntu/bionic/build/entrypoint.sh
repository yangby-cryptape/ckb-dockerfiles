#!/usr/bin/env bash

set -Eeo pipefail

RUN_AS="$(stat --format='%u:%g' .)"
DEFAULT_COMMAND="/bin/bash"

function usage () {
    echo "
Usage:

    $(basename $0) [--run_as UID:GID] [COMMAND [ARG1 [ARG2 [...]]]]

        UID:
                The user id used to run your command.
                Do not use user name.
                Default: the user id of current directory.
        GID:
                The group id used to run your command.
                Do not use group name.
                Default: the user id of current directory.

        COMMAND:
                If no command provided, the default is '${DEFAULT_COMMAND}'.
"
    exit $1
}

function add_group_and_user_if_not_existed() {
    local uid=$(echo ${RUN_AS} | cut -d: -f 1)
    local gid=$(echo ${RUN_AS} | cut -d: -f 2)
    local has_gid=$(awk -F: '{print $3}' /etc/group \
        | grep -c ^${gid}$)
    local has_uid=$(awk -F: '{print $4}' /etc/passwd \
        | grep -c ^${uid}$)
    if [ "${has_gid}" -eq 0 ]; then
        groupadd --gid=${gid} ${gid}
    fi
    if [ "${has_uid}" -eq 0 ]; then
        useradd -g ${gid} --uid=${uid} ${uid}
    fi
    if [ ! -d "/home/${uid}" ]; then
        cp -r "/etc/skel" "/home/${uid}"
        chown -R "${uid}:${gid}" "/home/${uid}"
    fi
}

function main () {

    if [ $# -ge 2 ] && [ "${1}" = "--run_as" ]; then
        if [[ "${2}" =~ ^[0-9]{1,}:[0-9]{1,}$ ]]; then
            RUN_AS="${2}"
            shift 2
        else
            usage 1
        fi
    fi

    add_group_and_user_if_not_existed

    chown -R ${RUN_AS} \
        "${CARGO_HOME}/git" \
        "${CARGO_HOME}/registry"

    # Don't care about the input commands.
    set +eo pipefail
    if [ $# -eq 0 ]; then
        echo "[Debug] Run command [${DEFAULT_COMMAND}] as ${RUN_AS}."
        exec gosu ${RUN_AS} "${DEFAULT_COMMAND}"
    else
        echo "[Debug] Run command [$*] as ${RUN_AS}."
        exec gosu ${RUN_AS} "$@"
    fi
}

main "$@"
