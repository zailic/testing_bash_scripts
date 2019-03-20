#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__tools_dir="${__dir}/tools"
__bash_unit_tool="${__tools_dir}/bash_unit"
__tests_dir="${__dir}/tests"

"${__bash_unit_tool}" "${__tests_dir}"/test_* > /dev/null
