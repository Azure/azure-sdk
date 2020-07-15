# Azure SDK Contribution Guide

The Azure SDK project welcomes contributions and suggestions.  Most contributions require you to agree to a Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions provided by the bot. You will only need to do this once across all repos using our CLA.

## Contribution Process

Here's the general contribution process:

1. Fork this repo
1. Create a new branch
1. Commit your changes to that branch
1. Do a PR from your fork/branch to azure-sdk/master.

## Website Setup

This site uses Jekyll and GitHub pages. Installation instructions can be found here: https://jekyllrb.com/docs/installation

Here's how to setup the site locally:

1. [Install Ruby+DevKit 2.6](https://rubyinstaller.org/downloads/) - Don't install 2.7, it doesn't work with this site.

    You can find complete installation instructions here: https://jekyllrb.com/docs/installation

1. Restart your machine

    You may need to restart your machine after installing Ruby.

1. Install Jekyll

    ```bash
    gem install jekyll bundler
    ```

1. Install Dependencies

    Run the following command from the root of the azure-sdk project.

    ```bash
    bundle install
    ```

1. Open a terminal and execute the following command to start the site:

    ```bash
    bundle exec jekyll serve
    ```

1. Open a browser to https://127.0.0.1:4000 to run the site.