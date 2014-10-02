from django import forms
from ideas.models import UserProfile, Ideas, Sparks, Actions
from django.contrib.auth.models import User

class UserForm(forms.ModelForm):
	password = forms.CharField(widget=forms.PasswordInput())

	class  Meta:
		model = User
		fields = ('username', 'email', 'password')

class UserProfileForm(forms.ModelForm):
		class Meta:
			model = UserProfile
			fields = ('website',)

class IdeasForm(forms.ModelForm):
	
	title = forms.CharField(widget=forms.TextInput(attrs={'class': 'input'}),max_length="250", help_text="Share your idea")
	is_parent = forms.BooleanField(widget=forms.HiddenInput())
	parent_id = forms.IntegerField(widget=forms.HiddenInput(), required=False)
	user = forms.ModelChoiceField(queryset=User.objects.all(),widget=forms.HiddenInput())
	class Meta:
		model = Ideas
		fields = ('title', 'user', 'is_parent', 'parent_id')	


class ActionsForm(forms.ModelForm):
	class Meta:
		model = Actions
		fields = ('idea', 'action', 'url')

class SparksForm(forms.ModelForm):
	class Meta:
		model = Sparks
		fields = ('idea', 'spark', 'url')
