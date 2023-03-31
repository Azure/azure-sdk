---
title: "Policies: Repository Branching"
permalink: policies_repobranching.html
folder: policies
sidebar: general_sidebar
---

The git branching and workflow strategy we will be using is mostly in line with [OneFlow](https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow) with some slight variations called out below.

## Main branch

`main` is the main default branch that lives forever and should never be force pushed to. The main branch must always be in a working state where CI builds succeed (e.g. build, analyze, and tests passing).  All other branches are intentionally short lived and should be removed once they are no longer needed.

While main will always be in a buildable state it will not necessarily always represent the state of the latest official published packages. To figure out the state of the code for a given released package you need to use the tag for that released package. This rule might vary between the different language repos as some languages that allow direct references to source code (i.e. python, js) like to keep the main branch matching the latest published official package and so you may need to refer to specific instructions in the language repos for the rules.

## Work should happen in Forks

In order to help reduce the clutter of branches in the main repo as well as to enable a common workflow for both contributors and community members with different permissions people should create forks of the main repository and work in them. Once work is ready in the fork then a pull request can be submitted back to the main repository.

See the next few sections for some simple getting started instructions for using forks but for more detailed documentation from github see [working-with-forks](https://help.github.com/en/articles/working-with-forks).

### Clone forked repo

After you have created your own fork by clicking the fork button on the main repo you can use the following commands to clone and set up your local repo.

```bash
# clone your forked repo locally which will setup your origin remote
git clone https://github.com/<your-github-username>/azure-sdk-for-<lang>.git

# add an upstream remote to the main repository.
cd azure-sdk-for-<lang>
git remote add upstream https://github.com/Azure/azure-sdk-for-<lang>.git

git remote -v
# origin    https://github.com/<your-github-username>/azure-sdk-for-<lang>.git (fetch)
# origin    https://github.com/<your-github-username>/azure-sdk-for-<lang>.git (push)
# upstream  https://github.com/Azure/azure-sdk-for-<lang>.git (fetch)
# upstream  https://github.com/Azure/azure-sdk-for-<lang>.git (push)
```

After you have ran those commands you should be all setup with your local cloned repo, a remote for your forked repo called origin, and a remote for the main repo called upstream.

### Sync your local and forked repo with latest changes from the main repo

Working in a fork is highly recommended so you should avoid committing changes directly into main and you can use it to sync your various repos. The instructions in this section assume you are using main as your syncing branch.

```bash
# switch to your local main
git checkout main

# update your local main branch with what is in the main repo
git pull upstream main --ff-only

# update your forked repo's main branch to match
git push origin main
```

At this point all three of your repos - local, origin, and upstream - should all match and be in sync.

Note that in order to ensure that we don't accidently get our local or origin main out of sync we use the `--ff-only` (fast-forward only) option which will fail if you have any commits that aren't already in the main repo. If you ever get into this state the easiest thing to do is to force reset your local main branch.

```bash
# Warning: this will remove any commits you might have in your local main so if
# you need those you should stash them in another branch before doing this
git reset --hard upstream/main

# If you also have your forked main out of sync you might need to use the force option when you push those changes
git push origin main -f
```

### Creating a branch and pushing it to your fork

After your local main branch is in-sync with the upstream main you can now create a branch and do work.

```bash
git checkout <branch-name>

# Make changes
# Stage changes for commit
git add <file-path> # or * for all files
git commit

git push origin <branch-name>
```

At this point you should be able to go to the main repository on github and see a link to create a pull request with the changes you pushed.

_Tip_: Some folks like to quickly stage and commit with a simple message at the same time you can use the following command for that.

```bash
git commit -am "Commit message"
```

Note that `-a` means commit all files that have changes so be sure to not have any other modified files in your working directory. The `-m` allows you to pass a commit message at the command line and is useful for quick commits but you might want to use your configured editor for better commit messages when pushing changes you want to be reviewed and merged into the main repo.

### Rebase changes on top of latest main

If you have changes that you have been working on and you need to update them with the latest changes from main, you should do the following commands after you have sync'ed your local main.

```bash
git checkout <branch-name>

# The rebase command will replay your changes on top of your local main branch
# If there are any merge conflicts you will need to resolve them now.
git rebase main

# Assuming there were new changes in main since you created your branch originally rebase will rewrite the commits and
# as such will require you to do a force push to your fork which is why the '-f' option is passed.
git push origin <branch-name> -f
```

_Tip_: if you want to squash changes you can add the `-i` to the rebase command for interactive mode to select which commits you want to squash, see [interactive mode](https://www.git-scm.com/docs/git-rebase#_interactive_mode) for information.

## Feature branches

For isolated work people should create branches off main and keep them in their local or forked repository. The name for these branches is up to the individual working on the changes and doesn't need to match the `feature` naming scheme but instead should match what the set of changes people are making. Once the work is ready the changes should be rebased on top of main and a pull request should be submitted to the main repository.

If there are a set of people that need to collaborate on the same set of changes before they can go into main then a feature branch can be pushed to the main repository for sharing. Collaborators can either work together to push changes to that branch or submit pull requests against it until it is ready to go to main. Once the feature work is ready the changes should be rebased on top of main and a pull request submitted to the main branch in the main repository. Once the feature work pull request is complete then the branch should be deleted from the main repository.

The feature branches pushed to the main repo should be named like `feature/<feature name>`

## Release tagging

For each package we release there will be a unique git tag created that contains the name and the version of the package to mark the commit of the code that produced the package. This tag will be used for servicing via hotfix branches as well as debugging the code for a particular version.

Format of the tag should be `<package-name>_<package-version>`

**_Note:_** Our release tags should be considered immutable.  Avoid updating or deleting them after they are pushed. If you need to update or delete one for some exceptional case, please contact the engineering system team to discuss options.

## Release branches

There are potentially 3 different types of release branches in the order of preference:

- `main`
- `release/<release name>`
- `feature/<feature name>`

In general there should not be a need for release branches because most releases will happen directly from main. In some cases there may be a need to lock down the branch to stabilize a package and in these cases we should create a release branch named `release/<release name>` and push it to the main repository. We do this to avoid ever locking down the main branch from taking other work. After any changes have been made and the release build produced the branch should be merged (not rebased) back into main, including the tagged release commit, and then the release branch should be deleted.

There may be other circumstances where we need to release a beta of a package from another branch outside of main or a release branch. In those cases we should use a feature branch in the main repository (note that we should not do stable releases out of feature branches so ensure the version is correctly marked as a beta). The release should be done in the same way, including the creation of the release tag, with the only difference being the release build should point to this feature branch instead of main. When the work is done this feature branch should be merged into main instead of rebased as generally recommended for feature branches. This allows us to preserve the release tags in main after we delete the feature branch.

When doing any releases outside of main extra caution needs to be taken to ensure the version numbers are correct and don't conflict with main or any other branch that might be releasing the same package.

## Hotfix branches

Under some circumstances we may need to service a specific version of the code with a hotfix and in these cases we should create a branch with the name `hotfix/<hotfix name>`, where `<hotfix name>` should have at least the name of the package or service and a short description or version number with it. That branch should be created from the git release tag that points at the specific version we want to hotfix and pushed to the main repository.

```bash
# If you need help finding the exact case-sensitive tag name:
git tag -l <package-name>*

git checkout -b hotfix/<hotfix name> <package-name>_<package-version>
git push upstream hotfix/<hotfix name>
```

After you have the main hotfix branch created you should use your usual workflow (i.e. create another branch or work on the same named branch in your fork) and the changes should be made and the version number incremented based on our [versioning guidance](releases.md#package-versioning) for the package. If the fixes are already made in main or another branch you can cherry-pick (`git cherry-pick <sha>`) them into your working branch, otherwise make the code edits as needed. Once all the changes are ready submit a PR against the `hotfix/<hotfix name>` branch you created in the main repo. PR validation should kick in automatically as long as the branch follows the `hotfix/*` naming convention. Once CI is green then the fix can be merged into the `hotfix/<hotfix name>` branch.

After the changes are merged into the `hotfix/<hotfix name>` branch the same release process we use for main can be used to produce a release out of that branch but when you queue the build be sure to set the branch name to the `hotfix/<hotfix name>`.

If the changes were not cherry-picked from `main` and they are needed there:

1. Fetch the latest upstream `main` e.g., `git fetch upstream main`
2. Create and check out a topic branch from upstream `main` e.g., `git checkout -b merge-hotfix/<hotfix name> upstream/main`
3. Merge your `hotfix/<hotfix name>` branch e.g., `git merge hotfix/<hotfix name>`

   When merging accept the version numbers from `main` and make sure CHANGELOG entries are sorted by date then version.

4. Push the topic branch to your origin remote e.g., `git push origin merge-hotfix/<hotfix name>`
5. Create a PR to merge into `main`. The output from pushing to a remote should include a link you can click to simplify this process.

Once the hotfix has been released and any changes merged back to `main` then you should delete the `hotfix/<hotfix name>` branch, it can always be recreated in the future from the last release tag if needed.
