# cf-smoke-tests-release

## Updating Blobs
Grab `private.yml` from Lastpass (cf-smoke-test-release-bucket aws key)

Run `bosh add-blob` with the correct source and destination

Run `bosh upload-blobs` to update the blobs

Run `bosh remove-blob` with the old blob you want to remove

## Creating a release locally

Run `git submodule update --init --recursive`

Run `bosh create-release` (probably with `--force`
if you've made changes that aren't checked in)

## Update Go Version

To update go version cf-smoke-test-release. Grab the S3 key for the cf-smoke-test-release blobs bucket.

Clone the golang-release: https://github.com/bosh-packages/golang-release
Make sure the repo is on a branch with the new go version.

Next follow the steps, but it should be just running:

`bosh vendor-package golang-1.12-windows <path to the golang-release>`

and

`bosh vendor-package golang-1.12-linux <path to the golang-release>`

Then commit.
