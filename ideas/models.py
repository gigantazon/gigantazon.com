from django.db import models
from django.contrib.auth.models import User
from datetime import datetime
from django.utils.text import slugify

# Create your models here.

class UserProfile(models.Model):
	user = models.OneToOneField(User)
	username = models.CharField(max_length=25)
	website = models.URLField(blank=True)
	
	def __unicode__(self):
		return self.user.username

class Ideas(models.Model):
	title = models.CharField(max_length=250)
	user = models.ForeignKey(User)
	date = models.DateTimeField(auto_now=True)
	is_parent = models.BooleanField(default=True)
	parent_id = models.ForeignKey('self', blank=False)

class Sparks(models.Model):
	idea = models.ForeignKey(Ideas)
	spark = models.CharField(max_length=300)
	url = models.URLField(blank=True)
	date = models.DateTimeField(auto_now=True)

class Actions(models.Model):
	idea = models.ForeignKey(Ideas)
	action = models.CharField(max_length=300)
	url = models.URLField(blank=True)
	date = models.DateTimeField(auto_now=True)
