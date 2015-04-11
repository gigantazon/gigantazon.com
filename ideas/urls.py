from django.conf.urls import patterns, url
from django.views.generic import TemplateView
from ideas import views

urlpatterns = patterns('',
        url(r'^$', views.ideas, name='ideas'),
        url(r'^register/$', views.register, name='register'),
        url(r'^login/$', views.user_login, name='user_login'),
        url(r'^logout/$', views.user_logout, name='user_logout'),
        url(r'^view/(?P<idea_id>\w+)/$', views.view_idea, name='view_idea'),
        url(r'^view/subs/(?P<idea_id>\w+)/$', views.get_idea_subs, name='get_subs'),
        url(r'^view/is_parent/(?P<idea_id>\w+)/$', views.is_parent, name='is_parent'),
        url(r'^view/map/(?P<idea_id>\w+)/$', views.d3_map, name='d3_map'),
        url(r'^profile/$', views.profile, name='profile'),
        url(r'^search/$', views.search, name='search'),
        url(r'^faq/$', TemplateView.as_view(template_name="ideas/faq.html")),
        url(r'^password/reset/$', 
         'django.contrib.auth.views.password_reset', 
         {'post_reset_redirect' : '/ideas/password/reset/done/', 
         'template_name': 'ideas/pwreset_form.html',
         'email_template_name': 'ideas/pwreset_email.html'},
         name="password_reset"),
        url(r'^password/reset/done/$',
         'django.contrib.auth.views.password_reset_done',
         {'template_name': 'ideas/pwreset_done.html'}),
        url(r'^password/reset/(?P<uidb64>[0-9A-Za-z]+)-(?P<token>.+)/$', 
         'django.contrib.auth.views.password_reset_confirm', 
         {'post_reset_redirect' : '/ideas/password/done/',
          'template_name': 'ideas/pwreset_confirm.html'}),
        url(r'^password/done/$', 
         'django.contrib.auth.views.password_reset_complete',
          {'template_name': 'ideas/pwreset_complete.html',
           'current_app': 'ideas'}),
)
