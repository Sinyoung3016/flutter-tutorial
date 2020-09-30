from django.shortcuts import render

# Create your views here.
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import Quiz
from .serializer import QuizSerializer

import random


#view를 만들면, 바로 url을 만들기

@api_view(['GET'])
def helloAPI(request):
    return Response("Hello world!")


@api_view(['GET'])
def randomQuiz(request, id): #입력한 개수, id만큼의 랜덤한 퀴즈 반환
    totalQuizs = Quiz.objects.all()
    randomQuizs = random.sample(list(totalQuizs), id)
    serializer = QuizSerializer(randomQuizs, many=True)
    return Response(serializer.data)