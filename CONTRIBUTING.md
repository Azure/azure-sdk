# Azure SDK Contribution Guide

The Azure SDK project welcomes contributions and suggestions.  Most contributions require you to agree to a Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions provided by the bot. You will only need to do this once across all repos using our CLA.

## Azure SDK Blog Contributions

The [Azure SDK Blog](https://aka.ms/azsdk/blog) welcomes contributions related to the new Azure SDKs.  Please reach out to us here [azsdkblog@microsoft.com](mailto:azsdkblog@microsoft.com) if you are interested in contributing a blog post.

## Azure SDK GitHub Pages Site Contributions

Here's the general contribution process:

1. Fork this repo
1. Create a new branch
1. Commit your changes to that branch
1. Do a PR from your fork/branch to azure-sdk/main.

## Codespaces

Codespaces is new technology that allows you to use a container as your development environment. This repo provides a Codespaces container which is supported by both GitHub Codespaces and VS Code Codespaces.

### GitHub Codespaces

1. From the Azure SDK GitHub repo, click on the "Code -> Open with Codespaces" button.
1. Open a Terminal
1. Execute the following command and `Ctrl+Click` the link generated.  A new window will open with the Azure SDK website.

    ```bash
    bundle exec jekyll serve
    ```

### VS Code Codespaces

1. Install the [VS Code Remote Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
1. When you open the Azure SDK repo in VS Code, it will prompt you to open the project in the Dev Container. If it does not prompt you, then hit CTRL+P, and select "Remote-Containers: Open Folder in Container..."
1. Open a Terminal
1. Press `Ctrl+Shift+T` or execute the following command and `Ctrl+Click` the link generated.  A new window will open with the Azure SDK website.

    ```bash
    bundle exec jekyll serve
    ```

## Full Local Setup

This site uses Jekyll and GitHub pages. Installation instructions can be found here: https://jekyllrb.com/docs/installation

Github instructions can be found at https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll

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
    bundle exec jekyll serve --incremental
    ```

1. Open a browser to https://127.0.0.1:4000 to run the site.
