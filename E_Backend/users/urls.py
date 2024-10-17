# users/urls.py
from django.urls import path
from .views import SignUpAPIView, CustomUserAPIView , LoginAPIView
from .views import profile
from .views import ContactCreateView
urlpatterns = [
    path('signup/', SignUpAPIView.as_view(), name='signup'),
    path('users/', CustomUserAPIView.as_view(), name='user-list'),
    path('users/<int:pk>/', CustomUserAPIView.as_view(), name='user-detail'),
    path('login/', LoginAPIView.as_view(), name='login'),
    path('profile/', profile, name='profile'),
    path('contact/', ContactCreateView.as_view(), name='contact'),

]
