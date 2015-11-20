from django.shortcuts import render, render_to_response
from django.template import RequestContext
from django.http import HttpResponse, HttpResponseRedirect, Http404
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from ideas.models import Drops, UserProfile, Comments, Watch
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
import datetime
import string,random, operator
from django.core.mail import send_mail
# Create your views here.

def gen_small(size=6, chars=string.ascii_letters + string.digits):
	return ''.join(random.choice(chars) for _ in range(size))

def index(request):
    context = RequestContext(request)
    user_form = UserForm()
    profile_form = UserProfileForm()
    context_dict = {'user_form': user_form, 'profile_form': profile_form }
    return  render_to_response('ideas/index.html', context_dict, context)


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
	latestpage = request.GET.get('latest')
	mypage = request.GET.get('mypage')
	watchpage = request.GET.get('watchpage')

	try:
		paginator = paginator.page(page)
	except PageNotAnInteger:
		paginator = paginator.page(1)
	except EmptyPage:
		paginator = paginator.page(paginator.num_pages)

	latest = Drops.objects.order_by('-date')[:100]
	latest_page = Paginator(latest, 20)
	try:
		latest_page = latest_page.page(latestpage)
	except PageNotAnInteger:
		latest_page = latest_page.page(1)
	except EmptyPage:
		latest_page = latest_page.page(paginator.num_pages)

	user_form = UserForm()
	profile_form = UserProfileForm()

	context_dict = {'drop_parents': paginator, 'latest': latest_page, 'user_form': user_form, 'profile_form': profile_form }

	uid = request.user
	try:
		profile = UserProfile.objects.get(user=uid)
		context_dict['profile'] = profile
	except:
		pass
	try:
		mydrops = Drops.objects.filter(user=uid)
		my_page = Paginator(mydrops, 20)	
		try:
			my_page = my_page.page(mypage)
		except PageNotAnInteger:
			my_page = my_page.page(1)
		except EmptyPage:
			my_page = my_page.page(paginator.num_pages)

		context_dict['mine'] = my_page
		watching = Watch.objects.filter(user=uid,active=True)
		watch_page = Paginator(watching, 20)
		context_dict['watching'] = watching
	except:
		pass

	if request.method == 'POST':
		kwargs = { }
		uid = request.user
		kwargs['user'] = User.objects.get(username=uid)
		kwargs['data'] = request.POST['data']
		kwargs['short'] = gen_small()
		if request.POST.get('action-date'):
			duedate = request.POST.get('action-date')
			d = datetime.datetime.strptime(duedate, '%Y-%m-%dT%H:%M')
			kwargs['dueDate'] = d
		kwargs['drop_type'] = request.POST.get('type', 'idea')
		kwargs['url'] = request.POST.get('url', '')
		kwargs['user'] = uid
		parent = request.POST.get('parent', '')
		origin = request.POST.get('origin', '')
		if origin == " 0":
			o = parent
		else:
			o = origin

		if parent:
			p = Drops.objects.get(id=parent)
			kwargs['parent_id'] = p
			kwargs['origin_id'] = o
		d = Drops(**kwargs)
		
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

	drops = Drops.objects.get(id=title.id)

	if title.origin_id:
		origin = Drops.objects.get(id=title.origin_id)
	else:
		origin = ''

	views = title.views
	views = views + 1
	title.views = views
	title.save()


	user_form = UserForm()
	profile_form = UserProfileForm()

	context_dict = { 'title': title,'children': children, 'origin': origin, 'profile_form': profile_form, 'user_form': user_form , 'drops': drops}
	uid = request.user
	try:
		submitter = User.objects.get(username=title.user)
		context_dict['submitter'] = submitter
		profile = UserProfile.objects.get(user=uid)
		context_dict['profile'] = profile
		u = User.objects.get(username=uid)
		watching = Watch.objects.filter(drop=title,user=u,active=True)
		if watching:
			context_dict['watching'] = True
	except:
		pass


	return render_to_response('ideas/view.html', context_dict, context)

def get_idea_subs(request, idea_id):
	context = RequestContext(request)
	drops = Drops.objects.filter(parent_id=idea_id)

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
			new_user = authenticate(username=request.POST['username'], password=request.POST['password'])
			login(request, new_user)
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
		referer = request.META.get('HTTP_REFERER')
		context_dict = {'referer': referer}

		return render_to_response('ideas/login.html', context_dict,context)
		
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

def watch(request, drop_id):
	context = RequestContext(request)
	if request.method == 'GET':
		uid = request.user
		try:
			u = User.objects.get(username=uid)
			d = Drops.objects.get(id=drop_id)
		except:
			return HttpResponse("Failed")
		try:
			w = Watch.objects.get(user=u,drop=d)
			if w.active == False:
				w.active = True
				w.save()
				return HttpResponse("OK")
			else:
				return HttpResponse("Exists")
		except:
			w = Watch(user=u,drop=d)
			try: 
				w.save()
				return HttpResponse("OK")
			except:
				return HttpResponse("Failed")


def watch_remove(request, drop_id):
	context = RequestContext(request)
	uid = request.user
	if request.method == 'GET':
		u = User.objects.get(username=uid)
		d = Drops.objects.get(id=drop_id)
		w = Watch.objects.get(user=u,drop=d)
		w.active = False
		try: 
			w.save()
			return HttpResponse("OK")
		except:
			return HttpResponse("Failed")


def report(request):
	context = RequestContext(request)
	if request.method == 'POST':
		title = request.POST['drop_title']
		drop_id = request.POST['drop_id']
		subject = "Drop reported: ID: %s" % drop_id
		message = "The drop '%s' has been reported by a user for ToS violation" % title
		recipients = ['matt.iavarone@gmail.com']
		sender = 'admin@gigantazon.com'
		send_mail(subject, message, sender, recipients)
		context_dict={'title': title, 'id': drop_id}
		return render_to_response('ideas/report.html', context_dict, context)
	else:
		return HttpResponseRedirect('/ideas/')


def d3_ideas_map(request):
	context = RequestContext(request)
	drops = Drops.objects.all()

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