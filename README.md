# cf-smoke-tests-release

## Updating Blobs
Download the binary you would like to include as a blob

Grab `private.yml` from Lastpass (cf-smoke-test-release-bucket aws key) and copy the contents into `config/private.yml` in your local repo. Note that blob management does not require a bosh director.

Run `bosh add-blob` with the correct source and destination

Run `bosh upload-blobs` to update the blobs

Run `bosh remove-blob` with the old blob you want to remove

For the windows cf cli, ensure that references/regex patterns in the `/packages/cf_cli_windows/packages` and `/packages/cf_cli_windows/spec` files correctly match the newly uploaded binary file name

## Creating and validating a release locally

Run `git submodule update --init --recursive`

Run `bosh create-release` (probably with `--force`
if you've made changes that aren't checked in)

Get a bosh director with cf-deployment and update your bosh manifest to point smoke tests at the `latest` release

Run `bosh deploy` to have bosh pull that latest dev release

Run `bosh run-errand smoke-tests`

## Update Go Version

To update go version cf-smoke-test-release. Grab the S3 key for the cf-smoke-test-release blobs bucket.

Clone the golang-release: https://github.com/bosh-packages/golang-release
Make sure the repo is on a branch with the new go version.

Next follow the steps, but it should be just running:

`bosh vendor-package golang-1.12-windows <path to the golang-release>`

and

`bosh vendor-package golang-1.12-linux <path to the golang-release>`

Then commit.
