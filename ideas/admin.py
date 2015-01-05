from django.contrib import admin
from ideas.models import UserProfile, Drops, Comments

# Register your models here.
admin.site.register(UserProfile)
admin.site.register(Drops)
admin.site.register(Comments)
