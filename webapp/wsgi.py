"""
WSGI config for webapp project.
"""

import os
import sys

BASE_DIR = os.path.dirname(os.path.dirname(__file__))
sys.path.append(BASE_DIR)

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webapp.settings")

from django.core.wsgi import get_wsgi_application  # noqa: E402
from dj_static import Cling                        # noqa: E402

application = Cling(get_wsgi_application())
