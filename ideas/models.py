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
	data = models.CharField(max_length=250)
	url = models.URLField(max_length=1000,blank=True)
	drop_type = models.CharField(max_length=15)
	user = models.ForeignKey(User)
	date = models.DateTimeField(auto_now=True)
	parent_id = models.ForeignKey('self',null=True,blank=True)
	origin_id = models.PositiveSmallIntegerField(max_length=10,default=0)

	def __unicode__(self):
		return self.data

class Comments(models.Model):
		idea = models.ForeignKey(Drops)
		comment = models.CharField(max_length=5000)
		date = models.DateTimeField(auto_now=True)
		user = models.ForeignKey(User)
		path = dbarray.IntegerArrayField(blank=True,editable=False)
		depth = models.PositiveSmallIntegerField(default=0,blank=True)

		def __unicode__(self):
			return self.comment