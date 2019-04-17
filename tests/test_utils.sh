#!/bin/bash

# shellcheck disable=SC1091
source ./../includes/utils.sh

test_superuser_required() {
    assert_fail run_as_superuser_trap "Are you running these tests as root? You shouldn't:)"
}

test_should_get_error_message() {
    assert_equals "Error! Root privileges are required in order to run this script..." "$(run_as_superuser_trap 2>&1)" \
        "Are you running these tests as root? You shouldn't:)"
}
