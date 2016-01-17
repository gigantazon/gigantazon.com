from ideas.models import Drops, UserProfile, Comments
from django.contrib.auth.models import User
from rest_framework import serializers, pagination

class DropsSerializer(serializers.ModelSerializer):
	class Meta:
		model = Drops
		fields = ('id', 'data', 'url', 'drop_type', 'user', 'date', 'parent_id', 'origin_id')



class D3Serializer(serializers.ModelSerializer):
	name = serializers.CharField(source="data")
	class Meta:
		model = Drops
		fields = ( 'id', 'name', 'drop_type')
