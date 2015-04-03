from django.shortcuts import render, render_to_response
from django.template import RequestContext
from django.http import HttpResponse, HttpResponseRedirect, Http404
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from ideas.models import Drops, UserProfile, Comments
from ideas.forms import DropsForm, UserForm, UserProfileForm, CommentForm
from django.core.paginator import Paginator,EmptyPage, PageNotAnInteger
from django.core.urlresolvers import reverse
from itertools import chain
import json, collections
from django.forms.models import model_to_dict
from django.core import serializers
from django.db.models import Q
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser
from ideas.serializers import DropsSerializer, D3Serializer
# Create your views here.

def index(request):
	context = RequestContext(request)
    	return  render_to_response('ideas/index.html', context)

class JSONResponse(HttpResponse):
	def __init__(self, data, **kwargs):
		content = JSONRenderer().render(data)
		kwargs['content_type'] = 'application/json'
		super(JSONResponse, self).__init__(content, **kwargs)

def ideas(request):
	context = RequestContext(request)
	drop_parents = Drops.objects.filter(parent_id__isnull=True).order_by('-date')
	paginator = Paginator(drop_parents, 20)
	page = request.GET.get('page')
	try:
		paginator = paginator.page(page)
	except PageNotAnInteger:
		paginator = paginator.page(1)
	except EmptyPage:
		paginator = paginator.page(paginator.num_pages)



	latest = Drops.objects.order_by('-date')[:10]
	context_dict = {'drop_parents': paginator, 'latest': latest }

	uid = request.user
	try:
		profile = UserProfile.objects.get(user=uid)
		context_dict['profile'] = profile
	except:
		pass
	try:
		mydrops = Drops.objects.filter(user=uid)	
		context_dict['mine'] = mydrops
	except:
		pass

	if request.method == 'POST':
		uid = request.user
		user = User.objects.get(username=uid)
		data = request.POST['data']
		drop_type = request.POST.get('type', 'idea')
		url = request.POST.get('url', '')
		user = request.user
		parent = request.POST.get('parent', '')
		origin = request.POST.get('origin', '')
		if origin == " 0":
			o = parent
		else:
			o = origin

		if parent:
			p = Drops.objects.get(id=parent)
			d = Drops(data=data,user=user,drop_type=drop_type,url=url, parent_id=p,origin_id=o)
		else:
			d = Drops(data=data,user=user,drop_type=drop_type)
		
		try:
			d.save()
		except Exception, e:
			raise

		return HttpResponseRedirect('/ideas/view/%d/' % d.id)
		
	return render_to_response('ideas/ideas.html', context_dict, context)

def view_idea(request, idea_id):
	context = RequestContext(request)
	try:
		title = Drops.objects.get(pk=idea_id)
	except:
		raise	Http404("Idea does not exist")

	if title.parent_id:
		children = Drops.objects.filter(parent_id=title.id).count()
	else:
		children = Drops.objects.filter(origin_id=idea_id).count()

	views = title.views
	views = views + 1
	title.views = views
	title.save()

	context_dict = { 'title': title,'children': children }
	uid = request.user
	try:
		profile = UserProfile.objects.get(user=uid)
		context_dict['profile'] = profile
	except:
		pass
	return render_to_response('ideas/view.html', context_dict, context)

def get_idea_subs(request, idea_id):
	context = RequestContext(request)
	drops = Drops.objects.filter(Q(parent_id=idea_id)|Q(origin_id=idea_id))

	serializer = DropsSerializer(drops, many=True)
	return JSONResponse(serializer.data)

def d3_map(request, idea_id):
	context = RequestContext(request)
	drops = Drops.objects.filter(Q(parent_id=idea_id)|Q(origin_id=idea_id)|Q(id=idea_id))

	serializer = D3Serializer(drops, many=True)
	data = []
	for d in drops:
		if d.parent_id_id is None:
			data.append({'source': d.id, 'target': d.id, 'value': 0})
		else:
			data.append({'source': d.id, 'target': d.parent_id_id, 'value': 0})
	jdata = json.dumps(data)
	ldata = json.loads(jdata)


	return JSONResponse({'nodes': serializer.data, 'links': ldata})

def is_parent(request, idea_id):
	context = RequestContext(request)
	drops = Drops.objects.filter(parent_id=idea_id).count()
	return HttpResponse(drops)


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
			'ideas/register.html',
			{'user_form': user_form, 'profile_form': profile_form, 'registered': registered },
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
		return render_to_response('ideas/login.html', {'login_fail': "Invalid Credentials"},context)
		
def user_logout(request):
	logout(request)
	return HttpResponseRedirect('/')		

@login_required(login_url='/ideas/login/')
def profile(request):
	context = RequestContext(request)
	uid = request.user

	try:
		profile = UserProfile.objects.get(user=uid)
		drops = Drops.objects.filter(user=uid)		
	except:
		raise Http404



	context_dict = {'profile': profile, 'drops': drops }
	if request.method == 'POST':
		try:
			profile.picture = request.FILES['picture']
			profile.save()
		except Exception, e:
			raise
		return HttpResponseRedirect('/ideas/profile/')
	return render_to_response('ideas/profile.html', context_dict, context)
	

def search(request):
	context = RequestContext(request)
	uid = request.user
	if request.method == 'POST':
		srch = request.POST['search']
		ideas = Drops.objects.filter(Q(data__icontains=srch)).distinct('data')
		
		profile = UserProfile.objects.get(user=uid)

		context_dict={'srch_term': srch, 'drops': ideas, 'profile': profile}

		return render_to_response('ideas/search.html', context_dict, context)
	else:
		return HttpResponseRedirect('/ideas/')