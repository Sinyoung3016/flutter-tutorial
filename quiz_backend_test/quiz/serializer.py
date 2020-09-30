from rest_framework import serializers
from .models import Quiz

#Model -> JSON data로 변환하는 serializer
class QuizSerializer(serializers.ModelSerializer):
    class Meta:
        model = Quiz
        fields = ('title','body','answer')