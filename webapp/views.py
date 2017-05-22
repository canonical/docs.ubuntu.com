from django.http import HttpResponseNotFound, HttpResponseServerError
from django.template import loader


def custom_404(request):
    t = loader.get_template('404.html')
    return HttpResponseNotFound(t.render({'request_path': request.path}))


def custom_500(request):
    t = loader.get_template('500.html')
    return HttpResponseServerError(t.render({}))
