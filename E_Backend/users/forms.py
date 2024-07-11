# users/forms.py
from django import forms
from django.contrib.auth.forms import UserCreationForm
from .models import CustomUser

class CustomUserCreationForm(UserCreationForm):
    class Meta(UserCreationForm.Meta):
        model = CustomUser
        fields = ('email', 'full_name', 'phone_number', 'day_of_birth', 'month_of_birth', 'year_of_birth', 'id_number')
