from django.db import models
from django.contrib.auth.models import User
from datetime import datetime
from django.utils.text import slugify
import dbarray
from PIL import Image

# Create your models here.

import string,random

def gen_filename(size=16, chars=string.ascii_letters + string.digits):
	return ''.join(random.choice(chars) for _ in range(size))


def gen_short(size=8, chars=string.ascii_letters + string.digits):
	return ''.join(random.choice(chars) for _ in range(size))

class Category(models.Model):
	name = models.CharField(max_length=128, unique=True)
	img = models.CharField(max_length=50,null=True,blank=True)
	description = models.CharField(max_length=200, null=True, blank=True)

	def __unicode__(self):
		return self.name
	
class UserProfile(models.Model):
	user = models.OneToOneField(User)
	website = models.URLField(blank=True)
	picture = models.ImageField(upload_to='profile_images',default='profile_images/default.png',null=True,blank=True)
	thumb = models.ImageField(upload_to='profile_images',blank=True,null=True)

	def save(self, *args, **kwargs):


		from cStringIO import StringIO
		from django.core.files.uploadedfile import SimpleUploadedFile
		import os
		from django.core.files.storage import default_storage as storage

		imgname = gen_filename()
		temp_handle = StringIO()

		THUMBNAIL_SIZE = (65,65)
		image = Image.open(StringIO(self.picture.read()))

		if image.mode not in ('L', 'RGB'):
			image = image.convert('RGB')

		width, height = image.size
		if width > height:
			asp = float(width) / float(height)	
			height = 300
			width = height * asp
		else:
			asp = float(height) / float(width)
			width = 300
			height = width * asp
		new_size = int(width), int(height)

		smaller = image.resize((new_size), Image.ANTIALIAS)
		smaller_string = StringIO()
		smaller.save(smaller_string, 'PNG')
		smaller_string.seek(0)
		fullsuf = SimpleUploadedFile(imgname+'.png', smaller_string.read(), content_type='image/png')
		self.picture.save(imgname+'.png', fullsuf, save=False)

		image.thumbnail(THUMBNAIL_SIZE, Image.ANTIALIAS)

	
		image.save(temp_handle, 'png')
		temp_handle.seek(0)
		
		self.picture.name = 'profile_images/'+imgname+'.png'
		suf = SimpleUploadedFile(imgname+'.png.thumb', temp_handle.read(), content_type='image/png')
		self.thumb.save(imgname+'.png.thumb', suf, save=False)
		
		super(UserProfile, self).save()


	class Admin:
		pass	
	
	def __unicode__(self):
		return self.user.username

class Drops(models.Model):
	data = models.CharField(max_length=1500)
	url = models.URLField(max_length=1000,blank=True)
	drop_type = models.CharField(max_length=15)
	user = models.ForeignKey(User)
	category = models.ForeignKey(Category)
	date = models.DateTimeField(auto_now_add=True)
	dueDate = models.DateTimeField(null=True,blank=True)
	parent_id = models.ForeignKey('self',null=True,blank=True)
	origin_id = models.PositiveSmallIntegerField(max_length=10,default=0)
	views = models.PositiveSmallIntegerField(max_length=50, default=0)
	short = models.CharField(max_length=250,blank=True,null=True,unique=True)

	def __unicode__(self):
		return self.data

	def ideas(self):
		i = Drops.objects.filter(parent_id=self.id, drop_type='idea')
		return i

	def sparks(self):
		s = Drops.objects.filter(parent_id=self.id, drop_type='spark')
		return s

	def actions(self):
		a = Drops.objects.filter(parent_id=self.id, drop_type='action')
		return a

	def children(self):
		c = Drops.objects.filter(parent_id=self.id)
		return c

class Comments(models.Model):
		idea = models.ForeignKey(Drops)
		comment = models.CharField(max_length=5000)
		date = models.DateTimeField(auto_now_add=True)
		user = models.ForeignKey(User)
		path = dbarray.IntegerArrayField(blank=True,editable=False)
		depth = models.PositiveSmallIntegerField(default=0,blank=True)

		def __unicode__(self):
			return self.comment

class Watch(models.Model):
	user = models.ForeignKey(User)
	drop = models.ForeignKey(Drops)
	date = models.DateTimeField(auto_now_add=True)
	active = models.BooleanField(default=True)

	def __unicode__(self):
		return self.drop.data