from django.shortcuts import render, render_to_response
from django.template import RequestContext
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from ideas.models import Ideas, Sparks, Actions
from django.core.paginator import Paginator,EmptyPage, PageNotAnInteger
from django.core.urlresolvers import reverse

# Create your views here.

def index(request):
	context = RequestContext(request)
    	return  render_to_response('ideas/index.html', context)

def ideas(request):
	context = RequestContext(request)
	idea_list = Ideas.objects.order_by('-date').select_related()
	paginator = Paginator(idea_list, 10)
	page = request.GET.get('page')
	try:
		paginator = paginator.page(page)
	except PageNotAnInteger:
		paginator = paginator.page(1)
	except EmptyPage:
		paginator = paginator.page(paginator.num_pages)

	context_dict = {'idea_list': paginator}
	return render_to_response('ideas/ideas.html', context_dict, context)

def register(request):
	context = RequestContext(request)
	registered = False

	if request.method == 'POST':
		user_form = UserForm(data=request.POST)
		profile_form = UserProfileForm(data=request.POST)

		if user_form.is_valid() and profile_form.is_valid():
			user = user_form.save()
			user.set_password(user.password)
			user.save()
	
			profile = profile_form.save(commit=False)
			profile.user = user

			if 'picture' in request.FILES:
				profile.picture = request.FILES['picture']

			profile.save()
			registered = True
		else:
			print user_form.errors, profile_form.errors
	else:
		user_form = UserForm()
		profile_form = UserProfileForm()

	return render_to_response(
			'news/register.html',
			{'user_form': user_form, 'profile_form': profile_form, 'registered': registered, 'categories': cat_list(), 'root': "news"},
			context)


def user_login(request):
	context = RequestContext(request)
	if request.method == 'POST':
		username = request.POST['username']
		password = request.POST['password']
	
		user = authenticate(username=username, password=password)

		if user:
			if user.is_active:
				login(request, user)
				return HttpResponseRedirect('/ideas')
			else:
				return HttpResponse("Your account is disabled.")
		else:
			print "Invalid login details: {0}, {1}".format(username, password)
			return HttpResponseRedirect('/ideas/login/')

	else:
		return render_to_response('ideas/login.html', context)
		
def user_logout(request):
	logout(request)
	return HttpResponseRedirect('/')		
