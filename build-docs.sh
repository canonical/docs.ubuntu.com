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

    # Conjure-up docs
    folder="build/conjure-up"
    name="conjure-up"
    repo_url="https://github.com/canonicalltd/docs-conjure-up.git"

    if ! up_to_date ${folder} ${repo_url}; then
      refresh_repo ${folder} ${repo_url} master

      documentation-builder --base-directory "${folder}"  \
                            --site-root "/${name}/"  \
                            --output-path "templates/${name}"  \
                            --output-media-path "static/media/${name}"  \
                            --search-url "/search"  \
                            --search-placeholder "Search ${name} docs"  \
                            --search-domain "docs.ubuntu.com/${name}"  \
                            --build-version-branches  \
                            --media-url "/static/media/${name}"  \
                            --tag-manager-code "GTM-K92JCQ"  \
                            --no-link-extensions
    fi

    # Documentation-builder
    folder="build/documentation-builder"
    name="documentation-builder"
    repo_url="https://github.com/canonical-webteam/documentation-builder.git"

    if ! up_to_date ${folder} ${repo_url}; then
      refresh_repo ${folder} ${repo_url} master

      documentation-builder --base-directory "${folder}"  \
                            --site-root "/${name}/"  \
                            --output-path "templates/${name}"  \
                            --output-media-path "static/media/${name}"  \
                            --search-url "/search"  \
                            --search-placeholder "Search Builder docs"  \
                            --search-domain "docs.ubuntu.com/${name}"  \
                            --source-folder docs  \
                            --media-url "/static/media/${name}"  \
                            --tag-manager-code "GTM-K92JCQ"  \
                            --no-link-extensions
    fi

    # MAAS docs
    folder="build/maas"
    name="maas"
    repo_url="https://github.com/canonicalltd/maas-docs.git"

    if ! up_to_date ${folder} ${repo_url}; then
      refresh_repo ${folder} ${repo_url} master

      documentation-builder --base-directory "${folder}"  \
                            --site-root "/${name}/"  \
                            --output-path "templates/${name}"  \
                            --output-media-path "static/media/${name}"  \
                            --search-url "/search"  \
                            --search-placeholder "Search MAAS docs"  \
                            --search-domain "docs.ubuntu.com/${name}"  \
                            --build-version-branches  \
                            --media-url "/static/media/${name}"  \
                            --tag-manager-code "GTM-K92JCQ"  \
                            --no-link-extensions
    fi

    # Style Guide docs
    folder="build/styleguide"
    name="styleguide"
    repo_url="https://github.com/canonical-docs/praecepta.git"

    if ! up_to_date ${folder} ${repo_url}; then
      refresh_repo ${folder} ${repo_url} master

      documentation-builder --base-directory "${folder}"  \
                            --site-root "/${name}/"  \
                            --output-path "templates/${name}"  \
                            --output-media-path "static/media/${name}"  \
                            --search-url "/search"  \
                            --search-placeholder "Search Style Guide docs"  \
                            --search-domain "docs.ubuntu.com/${name}"  \
                            --media-url "/static/media/${name}"  \
                            --tag-manager-code "GTM-K92JCQ"  \
                            --no-link-extensions
    fi

    # Landscape docs
    folder="build/landscape"
    name="landscape"
    repo_url="https://github.com/canonicalltd/docs-landscape.git"

    if ! up_to_date ${folder} ${repo_url}; then
      refresh_repo ${folder} ${repo_url} master

      documentation-builder --base-directory "${folder}"  \
                            --site-root "/${name}/"  \
                            --output-path "templates/${name}"  \
                            --output-media-path "static/media/${name}"  \
                            --search-url "/search"  \
                            --search-placeholder "Search Landscape docs"  \
                            --search-domain "docs.ubuntu.com/${name}"  \
                            --media-url "/static/media/${name}"  \
                            --tag-manager-code "GTM-K92JCQ"  \
                            --no-link-extensions
    fi
}

build_docs
