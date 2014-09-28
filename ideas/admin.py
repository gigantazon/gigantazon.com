from django.contrib import admin
from ideas.models import UserProfile, Ideas, Sparks, Actions

# Register your models here.
admin.site.register(Ideas)
admin.site.register(Sparks)
admin.site.register(Actions)