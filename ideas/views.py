from django.shortcuts import render, render_to_response
from django.template import RequestContext
from django.http import HttpResponse, HttpResponseRedirect

# Create your views here.

def index(request):
	context = RequestContext(request)
        return  render_to_response('ideas/index.html', context)
