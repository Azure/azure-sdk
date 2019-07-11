# How to configure CODEOWNERS

GitHub offers a [CODEOWNERS file](https://help.github.com/en/articles/about-code-owners) feature. The CODEOWNERS file can be used by GitHub to automatically assign owners to pull requests when a pull request contains relevant file changes. We also use the CODEOWNERS file to automatically subscribe relevant owners to build failure notifications.

Use the following rules to ensure that we can use CODEOWNERS for both GitHub and build failure notification: 
* Use the `/.github/CODEOWNERS` file
* Follow the `/sdk/<service name>/` (with the leading and trailing slashes) convention to define service owners
  * When using this format service owners will be automatically subscribed to build notification failure alerts
* Place more general rules higher in the file and more specific rules lower in the file as GitHub uses the last matching expression
* Use only GitHub person aliases for the owners (e.g. `@person`). GitHub groups, GitHub users that aren't linked to internal users, internal group aliases, and email addresses are not supported at this time.

```gitignore
# Catch-all for SDK changes
/sdk/  @person1 @person2

# Service teams
/sdk/azconfig/   @person3 @person4
/sdk/keyvault/   @person5 @person6
/sdk/servicebus/ @person7 @person8
```

This example CODEOWNERS file has a catch-all list of owners at the top of the file and drills into specific service teams. GitHub uses the *last* matching expression to assign reviewers. For example, a PR with changes in `/sdk/keyvault/` will result in `@person5` and `@person6` being added to the PR. If a new service, like batch, were added with changes under `/sdk/batch/` then `@person1` and `@person2` will be assigned.

You can also use other features in how GitHub parses the [CODEOWNERS file](https://help.github.com/en/articles/about-code-owners) to build more complex logic for assigning PR reviewers. Please use these rules as a baseline so that our tools can refer to a consistent format for understanding service owners.
