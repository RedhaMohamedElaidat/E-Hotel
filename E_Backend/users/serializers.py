# users/serializers.py
from rest_framework import serializers
from .models import CustomUser

class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ('id', 'email', 'full_name', 'phone_number', 'day_of_birth', 'month_of_birth', 'year_of_birth', 'id_number', 'password')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = CustomUser.objects.create_user(
            email=validated_data['email'],
            full_name=validated_data['full_name'],
            phone_number=validated_data['phone_number'],
            day_of_birth=validated_data['day_of_birth'],
            month_of_birth=validated_data['month_of_birth'],
            year_of_birth=validated_data['year_of_birth'],
            id_number=validated_data['id_number'],
            password=validated_data['password']
        )
        return user
class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField()

    def validate(self, data):
        email = data.get('email', None)
        password = data.get('password', None)

        if email and password:
            user = CustomUser.objects.filter(email=email).first()

            if user and user.check_password(password):
                return {'user': user}
            raise serializers.ValidationError('Invalid email or password.')

        raise serializers.ValidationError('Must include "email" and "password".')
