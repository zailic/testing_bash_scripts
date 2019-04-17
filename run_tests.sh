#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__tools_dir="${__dir}/tools"
__shellcheck_tool="${__tools_dir}/shellcheck"
__bash_unit_tool="${__tools_dir}/bash_unit"
__tests_dir="${__dir}/tests"

ERRORS=()

echo "Run linting..."
# find all executables and run `shellcheck`
for f in $(find "${__dir}" -type f -not -iwholename "*.git*" -not -iwholename "*tools*" | sort -u); do
	if file "${f}" | grep --quiet "Bourne-Again shell"; then
		{
			 "${__shellcheck_tool}" -x "${f}" && echo "[OK]: successfully linted ${f}"
		} || {
			# add to errors
			ERRORS+=("${f}")
		}
	fi
done

if [[ ${#ERRORS[@]} -eq 0 ]]; then
	echo "No errors, hooray"
else
	printf "These files failed shellcheck:\n%s\n" "${ERRORS[@]}"
	exit 1
fi

echo "Run unit testing..."
"${__bash_unit_tool}" -f tap "${__tests_dir}"/test_* > "${__dir}/test_results_tap.txt"
echo "Done"

