# Use Ruby 2.7 version from approved Microsoft Container Registry.
# This image already contains the vscode:vscode user:group and sudoers support.
FROM mcr.microsoft.com/devcontainers/ruby:2.7-buster
ARG USERNAME=vscode

# The port on which Jekyll will serve the site
ARG PORT=4000
EXPOSE ${PORT}

# ENV Variables required by Jekyll
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TZ=America/Chicago

# Install packages as root
USER root

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && LANG=C LC_ALL=C apt-get -y install --no-install-recommends \
        apt-utils \
        dialog \
        sudo \
        #
        # Install vim, git, process tools, lsb-release
        git \
        openssh-client \
        less \
        locales \
    #
    # Add en_US.UTF-8 locale
    && echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen \
    #
    # Generate locale files
    && locale-gen \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to the non-root user
USER ${USERNAME}
SHELL ["/bin/bash", "-c"]

# Speed up subsequent `bundle install`
RUN echo 'gem: --no-ri --no-rdoc' > /home/${USERNAME}/.gemrc
