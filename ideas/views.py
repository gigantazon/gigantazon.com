from django.shortcuts import render, render_to_response
from django.template import RequestContext
from django.http import HttpResponse, HttpResponseRedirect
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

# Create your views here.

def index(request):
	context = RequestContext(request)
    	return  render_to_response('ideas/index.html', context)

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


	context_dict = {'drop_parents': paginator, 'latest': latest}
	if request.method == 'POST':
		form = DropsForm(data=request.POST)
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
			form = DropsForm(initial={'is_parent': True,'user': u.id})
			context_dict['form'] = form
		except:
			pass
		
	return render_to_response('ideas/ideas.html', context_dict, context)

def view_idea(request, idea_id):
	context = RequestContext(request)
	idea_data = Drops.objects.get(pk=idea_id)
	idea_subs = Drops.objects.filter(parent_id=idea_id)
	form = CommentForm(initial={'user': request.user, 'idea': idea_id})

	drops = Drops.objects.filter(Q(pk=idea_id)|Q(origin_id=idea_id))

	sql = "select id,data as name from ideas_drops where id=%(id)s or origin_id=%(id)s" % {'id': idea_id}
	nodes_raw = Drops.objects.raw(sql)
	objects_list = []
	for row in nodes_raw:
		d = collections.OrderedDict()
		d['name'] = row.name.replace('"', '\'')
		objects_list.append(d)
	j = json.dumps( objects_list )

	data = serializers.serialize('json', drops)
	context_dict = {'ideas': idea_data, 'subs': idea_subs,'form': form, 'json_data': data, 'json_nodes': j}

	if request.method == 'POST':
		form = CommentForm(request.POST)
		if form.is_valid():
			frm = form.save(commit=False)
			parent = form['parent'].value()

			if parent =='':
				frm.path = []
				frm.depth = 0
				frm.save()
				frm.path = [frm.id]
			else:
				node = Comments.objects.get(id=parent)
				if node.depth >= 5:
					frm.depth = 5
				else:
					frm.depth = node.depth + 1
				frm.path = node.path
				frm.save()
				frm.path.append(frm.id)
			frm.save()
			return HttpResponseRedirect('/ideas/view/' + idea_id)
		else:
			print form.errors

	try:
		comments = Comments.objects.filter(idea=idea_id).order_by('path')
		context_dict['comments'] = comments
	except:
		pass
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
		return render_to_response('ideas/login.html', context)
		
def user_logout(request):
	logout(request)
	return HttpResponseRedirect('/')		

def get_idea(request):
	context = RequestContext(request)
	idea_id=None
	if request.method == 'GET':
		idea_id = request.GET['idea_id']
	
	if idea_id:
		drops = Drops.objects.filter(parent_id_id=idea_id)
		data = serializers.serialize('json', drops)
	return HttpResponse(data, content_type='application/json')

def d3_map(request):
	context = RequestContext(request)
	drop_id=None
	if request.method == 'GET':
		drop_id = request.GET['drop_id']
	if drop_id:
		drops = Drops.objects.filter(Q(pk=drop_id)|Q(origin_id=drop_id))
		data = serializers.serialize('json', drops)
		return HttpResponse(drops, content_type='application/json')		
