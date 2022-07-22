#! /bin/bash

set -eu

cf_smoke_tests_release_dir="$(pwd)/cf-smoke-tests-release"
dirs="
${cf_smoke_tests_release_dir}/jobs
${cf_smoke_tests_release_dir}/packages/smoke_tests
${cf_smoke_tests_release_dir}/packages/smoke_tests_windows
"
for dir in $dirs; do
  find "$dir" -type f -exec sed -i -E "s/golang-1.[0-9]+-(windows|linux)/golang-${GO_VERSION}-\1/g" {} \;
done

if [[ $(git -C "$cf_smoke_tests_release_dir" status --porcelain) ]]; then
  git -C "$cf_smoke_tests_release_dir" status
  git config --global user.email "$GIT_USER_EMAIL"
  git config --global user.name "$GIT_USER_NAME"
  git -C "$cf_smoke_tests_release_dir" add "$cf_smoke_tests_release_dir"
  git -C "$cf_smoke_tests_release_dir" commit -m "Consume go ${GO_VERSION} in jobs and smoke test packages"
else
  echo "no change, skipping commit..."
fi