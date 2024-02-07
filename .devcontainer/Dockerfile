# Use Ruby version from https://pages.github.com/versions/
FROM mcr.microsoft.com/devcontainers/ruby:2.7-buster

# This Dockerfile adds a non-root 'vscode' user with sudo access. However, for Linux,
# this user's GID/UID must match your local user UID/GID to avoid permission issues
# with bind mounts. Update USER_UID / USER_GID if yours is not 1000. See
# https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG PORT=4000

# The port on which Jekyll will serve the site
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
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # Add sudo support for the non-root user
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
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