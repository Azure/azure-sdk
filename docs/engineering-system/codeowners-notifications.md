# Subscribe to notifications through CODEOWNERS

We are building a rudimentary interpreter for the GitHub [CODEOWNERS file](https://help.github.com/en/articles/about-code-owners). The CODEOWNERS file can be used by GitHub to automatically assign owners to pull requests when a pull request contains relevant file changes. Our parser uses a subset of the CODEOWNERS features to resolve Microsoft aliases and synchronize those contacts to Azure DevOps Notifications for a relevant pipeline.

We use the CODEOWNERS file to generate subscribers for various nightly pipelines. Like GitHub's implementation of CODEOWNERS, the *last* item matching the criteria will be used to define subscribers. It's possible to set broad criteria earlier in the file to ensure that someone is notified of test failures that have not been assigned specific owners.

This implementation of CODEOWNERS resolves GitHub aliases into Microsoft aliases. It does not support GitHub groups, non-Microsoft GitHub aliases, or full email addresses at this time. If there is a need, we can add those features to our backlog.

The parser looks for the last match on the directory path of the relevant pipeline. For example, if we're evaluating for a pipeline file in `/sdk/eventhubs/tests.yml` we'll look for a match with `/sdk/eventhubs/`.

For a given CODEOWNERS file the `/sdk/eventhubs/` will result in `@person7` and `@person8` being subscribed.

```gitignore
# Globbing strings are not supported, yet
*   @person0

# Does not match
/eng/pipelines/  @person1 @person2
/sdk/azconfig/   @person3 @person4

# Matches, but another match exists later in the file -- @person5 and @person6 will NOT be subscribed
/sdk/  @person5 @person6

# Later item matches -- @person7 and @person8 will be subscribed
/sdk/eventhubs/  @person7 @person8

# Does not match
/sdk/eventhubs/package @person9

# Does not match
/sdk/keyvault/   @person10
```

In the case of `/sdk/storage/tests.yml` we'll look for a match with `/sdk/storage/`... In this example the latest match is `/sdk/` so `@person5` and `@person6` will be synced to the notification Team in DevOps.

To use a CODEOWNERS file

1. Create a `CODEOWNERS` file in your repo
1. Populate with directories and owners like the above to enable automatic subscriptions. Use only person aliases. GitHub groups, non-Microsoft users, Microsoft group aliases, and email addresses are not supported at this time.
1. Refer to [GitHub documentation](https://help.github.com/en/articles/about-code-owners) to use CODEOWNERS features on GitHub

We will run the tool on a cadence that synchronizes contacts into the relevant groups. Users who are added or removed from the CODEOWNERS file will be added or removed from the relevant DevOps Teams.
