Ubuntu documentation service
===

[![Build Status](https://travis-ci.org/ubuntudesign/docs.ubuntu.com.svg?branch=master)](https://travis-ci.org/ubuntudesign/docs.ubuntu.com)

A central platform for hosting Ubuntu's various documentation portals.

Basic usage
---

To run the site locally:

``` bash
./rebuild-docs # Gather and build documentation
./run # Download containers, run the dev server and watch for sass changes
```

Now visit <http://127.0.0.1:8007>.

To see what other `./run` commands are available, run `./run usage`.

Run locally with functioning search
---
Connect to the Canonical VPN and run the site natively:

```bash
virtualenv env
env/bin/pip install -r requirements.txt
env/bin/python manage.py runserver 0.0.0.0:8007
```

Licenses
---

The content of this project is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International license](https://creativecommons.org/licenses/by-sa/4.0/), and the underlying code used to format and display that content is licensed under the [LGPLv3](http://opensource.org/licenses/lgpl-3.0.html) by [Canonical Ltd](http://www.canonical.com/).

---

@nottrobin is the champion for this project.

With ♥ from [Canonical](http://www.canonical.com/).
