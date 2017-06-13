"""
WSGI config for docs.ubuntu.com.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.8/howto/deployment/wsgi/
"""

import os
import sys

BASE_DIR = os.path.dirname(os.path.dirname(__file__))
sys.path.append(BASE_DIR)

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webapp.settings")

from django.core.wsgi import get_wsgi_application  # noqa: E402
from whitenoise.django import DjangoWhiteNoise     # noqa: E402

application = DjangoWhiteNoise(get_wsgi_application())
