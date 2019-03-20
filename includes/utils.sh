#!/bin/bash

function run_as_superuser_trap {
    if [[ $(id -u) -ne 0 ]]; then
        echo "Error! Root privileges are required in order to run this script."
        exit 1
    fi
}
