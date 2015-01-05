from django.db import models
from django.contrib.auth.models import User
from datetime import datetime
from django.utils.text import slugify
import dbarray

# Create your models here.

class UserProfile(models.Model):
	user = models.OneToOneField(User)
	username = models.CharField(max_length=25)
	website = models.URLField(blank=True)
	
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