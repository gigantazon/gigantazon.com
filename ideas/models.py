from django.db import models
from django.contrib.auth.models import User
from datetime import datetime
from django.utils.text import slugify

# Create your models here.

class UserProfile(models.Model):
	user = models.OneToOneField(User)
	website = models.URLField(blank=True)
	
	def __unicode__(self):
		return self.user.username

class Ideas(models.Model):
	title = models.CharField(max_length=128)
	user = models.ForeignKey(UserProfile)

class Sparks(models.Model):
	idea = models.ForeignKey(Ideas)
	spark = models.CharField(max_length=300)
	url = models.URLField(blank=True)

class Actions(models.Model):
	idea = models.ForeignKey(Ideas)
	action = models.CharField(max_length=300)
	url = models.URLField(blank=True)
