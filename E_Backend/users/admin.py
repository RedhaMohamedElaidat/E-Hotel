# users/admin.py
from django.contrib import admin
from .models import CustomUser
from .models import Contact  
# Register your models here.
admin.site.register(CustomUser)
@admin.register(Contact)
class ContactAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'email', 'message')  # Adjust fields as necessary


