# Modules
from django.conf.urls import url
from django_template_finder_view import TemplateFinder
from canonicalwebteam.yaml_responses.django_helpers import (
    create_redirect_views,
)


# Match any redirects first
urlpatterns = create_redirect_views()

# Try to find templates
urlpatterns += [url(r"^(?P<template>.*)/?$", TemplateFinder.as_view())]
