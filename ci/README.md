# cf-smoke-tests-release CI

## Purpose
This pipeline keeps the components of `cf-smoke-tests-release` up to date and verifies all changes with automated testing.
It also provides manually triggered jobs for publishing new final bosh releases.

### Automated Testing
All changes to `cf-smoke-tests-release` are automatically verified by the following steps:
- Claiming a working bosh-deployed CF environment (`stable-acquire-pool` job)
- Deploying the smoke tests with the same bosh director (`deploy-updated-smokes` job)
- Running the `smoke_tests` errand on that bosh deployment (`run-smokes-errand` job)
- Deleting the deployment of `cf-smoke-tests-release` and releasing the environment (`delete-smokes-deployment` job)

### Component bumping
Two jobs ensure that `cf-smoke-tests-release` uses the latest version of both `cf-smoke-tests` and the `cf-test-helpers`
repos by updating the submodules for each.

- `bump-cf-smoke-tests`
- `bump-cf-test-helpers`

### Cutting new final releases
The `create-final-release` job must be triggered manually, and will automatically create a bosh final release for the
latest commit to have passed the verification steps.
