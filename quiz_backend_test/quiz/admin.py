from django.contrib import admin
from .models import Quiz

# Register your models here.
admin.site.register(Quiz) #adminpage에서 quiz모델을 관리할 수있음
