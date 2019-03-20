#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__tools_dir="${__dir}/tools"

function __pushd () {
    # suppress output of pushd
    command pushd "$@" > /dev/null
}

function __popd () {
    # suppress output of popd
    command popd > /dev/null
}

function download() {
    # bash lint  tool
    if [[ ! -f "${__tools_dir}/shellcheck" ]]; then
        curl https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz | \
            tar -xJv --strip-components=1 -C "${__tools_dir}" shellcheck-stable/shellcheck
        chmod +x "${__tools_dir}/shellcheck"
    fi
    # bash unit
    if [[ ! -f "${__tools_dir}/bash_unit" ]]; then
        __pushd "${__tools_dir}"
        bash <(curl -s https://raw.githubusercontent.com/pgrange/bash_unit/master/install.sh)
        __popd
        chmod +x "${__tools_dir}/shellcheck"
    fi
    
}

download
