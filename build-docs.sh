#!/usr/bin/env bash
set -euo pipefail

refresh_repo() {
  folder=$1
  repo_url=$2
  branch=$3

  if [ ! -d "${folder}/.git" ]; then
    # Clone project if it doesn't exist in the workspace
    git clone -b ${branch} ${repo_url} ${folder}
  else
    # If it exists, update to the latest commit
    (
      cd ${folder}
      for remote in `git remote`; do git remote rm ${remote}; done
      git remote add origin ${repo_url}
      git fetch origin
      git remote set-head origin ${branch}
      git clean -fd
      git reset --hard HEAD
      git checkout ${branch}
      git reset --hard origin/${branch}
    )
  fi
}

up_to_date() {
  folder=$1
  repo_url=$2

  if [ -d ${folder}/.git ]; then
    remote_commit=$(git ls-remote ${repo_url} | grep HEAD | awk '{print $1;}')
    local_commit=$(git -C ${folder}/.git rev-parse HEAD)

    if [ "${remote_commit}" == "${local_commit}" ]; then
      echo "${folder} hasn't changed"
      return 0
    fi
  fi

  return 1
}

build_docs () {
    mkdir -p build

    # Style Guide docs
    folder="build/styleguide"
    name="styleguide"
    repo_url="https://github.com/canonical-docs/praecepta.git"

    if ! up_to_date ${folder} ${repo_url}; then
      refresh_repo ${folder} ${repo_url} main

      documentation-builder --base-directory "${folder}"  \
                            --site-root "/${name}/"  \
                            --output-path "templates/${name}"  \
                            --output-media-path "static/media/${name}"  \
                            --media-url "/static/media/${name}"  \
                            --tag-manager-code "GTM-KNX3CJC"  \
                            --no-link-extensions
    fi
}

build_docs
