# Modules
from django.urls import re_path
from django_template_finder_view import TemplateFinder


# Compatibility shim for older packages expecting django.conf.urls.url
from django.conf import urls as django_urls
django_urls.url = re_path


from canonicalwebteam.yaml_responses.django_helpers import (
    create_redirect_views,
)


# Match any redirects first
urlpatterns = create_redirect_views()

# Try to find templates
urlpatterns += [re_path(r"^(?P<template>.*)/?$", TemplateFinder.as_view())]
