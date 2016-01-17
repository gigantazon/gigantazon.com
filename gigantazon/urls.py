from django.conf.urls import patterns, include, url
from ideas import views
from django.contrib import admin
from django.views.generic import TemplateView
from django.conf import settings
from django.conf.urls.static import static

admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'gigantazon.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

  	url(r'^gzonadmin/', include(admin.site.urls)),
	url(r'^ideas/', include('ideas.urls')),
	url(r'^$', 'ideas.views.index', name='index'),
    url(r'^about/$', TemplateView.as_view(template_name="ideas/about.html")),
	url(r'^explore/$', TemplateView.as_view(template_name="ideas/explore.html")),
	url(r'^pricing/$', TemplateView.as_view(template_name="ideas/prices.html")),
	#url(r'^$', TemplateView.as_view(template_name='index2.html')),

) + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
