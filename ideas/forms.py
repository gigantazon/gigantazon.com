from django import forms
from ideas.models import UserProfile, Drops, Comments
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

class DropsForm(forms.ModelForm):
	
	data = forms.CharField(widget=forms.TextInput(attrs={'class': 'input'}),max_length="250", help_text="Share your idea")
	is_parent = forms.BooleanField(widget=forms.HiddenInput())
	parent_id = forms.IntegerField(widget=forms.HiddenInput(), required=False)
	origin_id = forms.IntegerField(widget=forms.HiddenInput(), required=False)
	user = forms.ModelChoiceField(queryset=User.objects.all(),widget=forms.HiddenInput())
	class Meta:
		model = Drops
		fields = ('data', 'user', 'origin_id', 'parent_id')	



class CommentForm(forms.ModelForm):
	parent = forms.CharField(widget=forms.HiddenInput(attrs={'class': 'parent'}), required=False)
	comment = forms.CharField(widget=forms.Textarea, max_length="5000", help_text="Comment")

	class Meta:
		model = Comments
		fields = ('comment', 'user', 'idea','depth','parent')