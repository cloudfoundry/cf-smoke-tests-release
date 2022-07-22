# cf-smoke-tests-release CI

## Purpose
This pipeline keeps the components of `cf-smoke-tests` and `cf-smoke-tests-release` up to date, and verifies all changes with automated testing.

## Where
The pipeline is public and runs at [app-runtime-deployments.ci.cloudfoundry.org/teams/main/pipelines/cf-smoke-tests](https://app-runtime-deployments.ci.cloudfoundry.org/teams/main/pipelines/cf-smoke-tests)

### Automated Testing
All changes to `cf-smoke-tests-release` are automatically verified by the following steps:
- Claiming a working bosh-deployed CF environment (`claim-cats-pool`)
- Deploying the smoke tests with the same bosh director (`deploy-updated-smokes`)
- Running the `smoke_tests` errand on that bosh deployment (`run-smokes-errand`)
- Deleting the `cf-smoke-tests-release` deployment (`delete-smokes-deployment`) and cutting a release (`create-final-release`)

### Component bumping
The following two pipeline jobs automatically bump dependencies in the `cf-smoke-tests` and `cf-smoke-tests-release` repositories respectively:
1. `update-cf-smoke-tests` bumps:
    * the [cf-test-helpers](https://github.com/cloudfoundry/cf-test-helpers) submodule
    * go (1.x minor versions only) and go modules in `go.mod`
2. `update-cf-smoke-tests-release` bumps:
    * the cf-smoke-tests submodule
    * the golang package (version is pinned to that found in `go.mod` in cf-smoke-tests)
    * references to the golang package in all files in `jobs/`, `/packages/smoke_tests` and `/packages/smoke_tests_windows`

### Cutting new final releases
The `create-final-release` job is triggered automatically when new commits to this repo pass the jobs `deploy-updated-smokes`, `run-smokes-errand` and `delete-smokes-deployment`, but not if those commits only change files matching the following paths: `releases/**`, `.final_builds/**`, `ci/**`, and `.envrc`
