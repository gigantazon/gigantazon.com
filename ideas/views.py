from django.shortcuts import render, render_to_response
from django.template import RequestContext
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from ideas.models import Ideas, Sparks, Actions, UserProfile
from ideas.forms import IdeasForm, SparksForm, ActionsForm
from django.core.paginator import Paginator,EmptyPage, PageNotAnInteger
from django.core.urlresolvers import reverse
from itertools import chain

# Create your views here.

def index(request):
	context = RequestContext(request)
    	return  render_to_response('ideas/index.html', context)

def ideas(request):
	context = RequestContext(request)
	idea_parents = Ideas.objects.filter(is_parent=True).order_by('-date')
	spark_list = Sparks.objects.order_by('-date')[:5]
	action_list = Actions.objects.order_by('-date')[:5]
	idea_list = Ideas.objects.order_by('-date')[:5]
	paginator = Paginator(idea_parents, 20)
	page = request.GET.get('page')
	try:
		paginator = paginator.page(page)
	except PageNotAnInteger:
		paginator = paginator.page(1)
	except EmptyPage:
		paginator = paginator.page(paginator.num_pages)

	all_results = list(chain(spark_list,action_list,idea_list))

	context_dict = {'idea_parents': paginator, 'results': all_results}
	if request.method == 'POST':
		form = IdeasForm(data=request.POST)
		if form.is_valid():
			ideas = form.save(commit=False)
			ideas.save()
			return HttpResponseRedirect('/ideas/')
		else:
			print form.errors
	
	else:
		uname = request.user.username
		try:
			u = User.objects.get(username=uname)
			form = IdeasForm(initial={'is_parent': True,'user': u.id})
			context_dict['form'] = form
		except:
			pass
		

	
	return render_to_response('ideas/ideas.html', context_dict, context)

def view_idea(request, idea_id):
	context = RequestContext(request)
	idea_data = Ideas.objects.get(pk=idea_id)
	idea_subs = Ideas.objects.filter(parent_id=idea_id)
	idea_sparks = Sparks.objects.filter(idea_id=idea_id)
	idea_actions = Actions.objects.filter(idea_id=idea_id)
	context_dict = {'ideas': idea_data, 'subs': idea_subs, 'sparks': idea_sparks,'actions': idea_actions}
	return render_to_response('ideas/view.html', context_dict, context)


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
