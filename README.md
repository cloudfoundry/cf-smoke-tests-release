# cf-smoke-tests-release

## Updating Blobs
Grab `private.yml` from Lastpass (cf-smoke-test-release-bucket aws key)

Run `bosh add-blob` with the correct source and destination

Run `bosh upload-blobs` to update the blobs

Run `bosh remove-blob` with the old blob you want to remove

## Creating a release locally

Run `bosh create-release` (probably with `--force`
if you've made changes that aren't checked in)
