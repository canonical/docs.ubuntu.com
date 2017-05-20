# Ubuntu documentation service

[![Build Status](https://travis-ci.org/ubuntudesign/docs.ubuntu.com.svg?branch=master)](https://travis-ci.org/ubuntudesign/docs.ubuntu.com)

A central platform for hosting Ubuntu's various documentation portals.

## Local development

### Dependencies

First [install Docker](https://www.docker.com/community-edition#/download). Linux users may need to add their use to the `docker` group.

Then install [git-repo](https://github.com/esrlabs/git-repo) and [documentation-builder](https://github.com/canonicalltd/documentation-builder). E.g.:

`` bash
sudo snap install git-repo documentation-builder
```

### Run the local development server

To run the site locally:

``` bash
./run # Download containers, run the dev server and watch for sass changes
```

The first time this will take along time as it downloads and builds the documentation.

Now visit <http://127.0.0.1:8007>.

To see what other `./run` commands are available, run `./run usage`.

## Licenses

The content of this project is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International license](https://creativecommons.org/licenses/by-sa/4.0/), and the underlying code used to format and display that content is licensed under the [LGPLv3](http://opensource.org/licenses/lgpl-3.0.html) by [Canonical Ltd](http://www.canonical.com/).

---

@nottrobin is the champion for this project.

With ♥ from [Canonical](http://www.canonical.com/).
