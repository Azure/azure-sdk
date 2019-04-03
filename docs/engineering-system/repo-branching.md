The git branching and workflow strategy we will be using is mostly in line with [OneFlow](https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow) with some slight variations called out below.

## Main branch

`master` is the main default branch that lives forever and should never be force pushed to. The master branch must always be in a working state where CI builds succeed (e.g. build, analyze, and tests passing).  All other branches are intentionally short lived and should be removed once they are no longer needed.

While master will always be in a buildable state it will not necessarily always represent the state of the latest official published packages. To figure out the state of the code for a given released package you need to use the tag for that released package. This rule might vary between the different language repos as some languages that allow direct references to source code (i.e. python, js) like to keep the master branch matching the latest published official package and so you may need to refer to specific instructions in the language repos for the rules.

## Work should happen in Forks

In order to help reduce the clutter of branches in the main repo as well as to enable a common workflow for both contributors and community members with different permissions people should create forks of the main repository and work in them (see https://help.github.com/en/articles/working-with-forks). Once work is ready in the fork then a pull request can be submitted back to the main repository.

## Feature branches

For isolated work people should create branches off master and keep them in their local or forked repostory. The name for these branches is up to the individual working on the changes and doesn't need to match the `feature` naming scheme but instead should match what the set of changes people are making. Once the work is ready the changes should be rebased on top of master and a pull request should be submitted to the main repository.

If there are a set of people that need to collaborate on the same set of changes before they can go into master then a feature branch can be pushed to the main repository for sharing. Collaborators can either work together to push changes to that branch or submit pull requests against it until it is ready to go to master. Once the feature work is ready the changes should be rebased on top of master and a pull request submitted to the master branch in the main repository. Once the feature work pull request is complete then the branch should be deleted from the main repository.

The feature branches pushed to the main repo should be named like `feature/<feature name>`

## Release tagging

For each package we release there will be a unique git tag created that contains the name and the version of the package to mark the commit of the code that produced the package. This tag will be used for servicing via hotfix branches as well as debugging the code for a particular version.

Format of the tag should be `<package-name>_<package-version>`

Example of how to create a 1.0.0 release tag for the azure-keyvault package:

```
> git tag --annotate --message "1.0.0 release of azure-keyvault" azure-keyvault_1.0.0 HEAD
```

## Release branches

There are potentially 3 different types of release branches in the order of preference:
 - `master`
 - `release/<release name>`
 - `feature/<feature name>`

In general there should not be a need for release branches because most releases will happen directly from master. In some cases there may be a need to lock down the branch to stabilize a package and in these cases we should create a release branch named `release/<release name>` and push it to the main repository. We do this to avoid ever locking down the master branch from taking other work. After any changes have been made and the release build produced the branch should be merged (not rebased) back into master, including the tagged release commit, and then the release branch should be deleted.

There may be other circumstances where we need to release a preview of a package from another branch outside of master or a release branch. In those cases we should use a feature branch in the main repository (note that we should not do stable releases out of feature branches so ensure the version is correctly marked as a preview). The release should be done in the same way, including the creation of the release tag, with the only difference being the release build should point to this feature branch instead of master. When the work is done this feature branch should be merged into master instead of rebased as generally recommended for feature branches. This allows us to preserve the release tags in master after we delete the feature branch.

When doing any releases outside of master extra caution needs to be taken to ensure the version numbers are correct and don't conflict with master or any other branch that might be releasing the same package.

## Hotfix branches

Under some circumstances we may need to service a specific version of the code with a hotfix and in these cases we should create a branch from the git tag that points at the specific version we want to hotfix with a name of `hotfix/<appropriate name for what is being hotfixed>` and push it to the main repository. Once the branch is created the changes should be made and the version numbers for the package with the fix should be updated accordingly and then a build should be produced and verified. Once the package is released then the branch should be merged (not rebased) back into master, including the newly tagged release commit, and then the hotfix branch should be deleted.

Whenever we release a package that we need to support long term we need to ensure we have enough versioning space to release hotfixes at any point in the history of the package. To help ensure that we always need to bump at least the minor version (i.e. 2nd part) of the package because we will increment the patch (i.e. 3rd part) version each time we release a hotfix.