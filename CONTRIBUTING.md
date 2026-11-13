# Contributions are always welcome!

## Did you find a bug?

* Ensure the bug was not already reported by searching the open issues of this
  repository.
* Check the closed issues for solutions to problems other users had.
* If you're unable to find an issue addressing your problem, open a new issue.
* Be sure to include a clear title and a clear description, log files,
  screenshots and/or code samples so that we can understand and reproduce the
  problem.

## Do you want to contribute code?

Thanks for your interest in contributing. Anybody is free to propose any changes
to this repository using Pull Requests. We appreciate every Pull Request, but
merging cannot be guaranteed. Before you submit your code, please check the
following prerequisites: 
 
* use git to manage your changes [*recommended*]
* please follow common code conventions
* add the required copyright header to each new file introduced, see [licensing
  information](LICENSE) [**required**]
* structure patches logically, in small steps [**required**]
    * one separable functionality/fix/refactoring = one patch
    * do not mix those three into a single patch (e.g. first refactor, then add
      a new functionality that builds onto the refactoring)
    * after each patch, the tree still has to build and work, i.e. do not add
      even temporary breakages inside a patch series (helps when tracking down
      bugs)
    * use `git rebase -i` to restructure a patch series
* test patches sufficiently (obvious, but...) [**required**]
* after creating a Pull Request: if you haven't signed the [Siemens Contributor
  License Agreement
  (CLA)](https://github.com/siemens/.github/blob/main/cla/cla.md) in the past,
  you'll be automatically asked as part of your PR to sign it online at the
  specified URL. After you've signed the CLA, your PR will automatically be
  cleared for merging if all other test stages succeed.

## Releasing the Industrial Edge app

Pushing a `vX.Y.Z` tag builds the Edgeshark Industrial Edge apps for `amd64`
and `arm64` and publishes them as a GitHub release, as
`edgeshark-X.Y.Z-amd64.app.zip` and `edgeshark-X.Y.Z-arm64.app.zip`. Tags with a
pre-release suffix, such as `vX.Y.Z-rc.1`, are published as pre-releases. App
versions follow this scheme:

* `X.Y` is the major.minor version of the ghostwire image in
  [`deployments/industrial-edge/app/edgeshark/docker-compose.yml`](deployments/industrial-edge/app/edgeshark/docker-compose.yml);
  the release workflow fails otherwise.
* `Z` counts app revisions within `X.Y`: bump it for any change, such as a
  ghostwire patch release, a packetflix update, or deployment changes. Reset it
  to 0 when ghostwire's major or minor version changes.

The exact ghostwire and packetflix versions are automatically listed in the
release notes. To add further release notes, use an annotated tag, for instance:

```bash
git tag -a v2.7.2 -m "Show IE app icons and titles" \
    -m "Gostwire now gets a writable /tmp, needed for looking up IE app icons."
git push origin v2.7.2
```

The `arm64` app is derived on the fly from the same app template in
[`deployments/industrial-edge/app/`](deployments/industrial-edge/app/), as IE
requires each architecture to be a separate app: its `appId` and `title` are
overridden from
[`deployments/industrial-edge/app-arm64/detail.arm64.json`](deployments/industrial-edge/app-arm64/detail.arm64.json),
and its app repository directory is renamed from `edgeshark` to
`edgeshark-arm64`. Never change the `appId`s of already released apps.

## Thank you!
