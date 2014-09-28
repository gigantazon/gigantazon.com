from django import forms
from ideas.models import UserProfile, Ideas, Sparks, Actions
from django.contrib.auth.models import User

class UserForm(forms.ModelForm):
	passwod = forms.Charfield(widget=forms.PasswordInput())

	class = Meta:
		model = User
		fields = ('username', 'email', 'password')

class UserProfileForm(forms.ModelForm):
	class Meta:
		model = UserProfile
		fields = ('website', 'picture')