#! /bin/bash

set -e

version_output="$(pwd)/version"
cd cf-smoke-tests-release/src/smoke_tests
go mod edit -json | jq --raw-output .Go > "${version_output}/version"