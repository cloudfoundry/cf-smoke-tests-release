# cf-smoke-tests-release

This is the bosh release for [cf-smoke-tests](https://github.com/cloudfoundry/cf-smoke-tests). Once deployed, the tests can be run as a bosh errand:

```console
bosh -d <DEPLOYMENT> run-errand smoke_tests
```

## Contributing

### Updating Blobs
Download the binary you would like to include as a blob

Grab `private.yml` from Lastpass (cf-smoke-test-release-bucket aws key) and copy the contents into `config/private.yml` in your local repo. Note that blob management does not require a bosh director.

Run `bosh add-blob` with the correct source and destination

Run `bosh upload-blobs` to update the blobs

Run `bosh remove-blob` with the old blob you want to remove

For the windows cf cli, ensure that references/regex patterns in the `/packages/cf_cli_windows/packages` and `/packages/cf_cli_windows/spec` files correctly match the newly uploaded binary file name

### Creating and validating a release locally

Run `git submodule update --init --recursive`

Run `bosh create-release` (probably with `--force`
if you've made changes that aren't checked in)

Get a bosh director with cf-deployment and update your bosh manifest to point smoke tests at the `latest` release

Run `bosh deploy` to have bosh pull that latest dev release

Run `bosh run-errand smoke-tests`