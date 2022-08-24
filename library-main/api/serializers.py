# from rest_framework import serializers
from lib2to3.pgen2.token import OP
from operator import rshift
from telnetlib import LOGOUT
from turtle import title
from urllib import response
from django.forms import DateField
from rest_framework.serializers import ModelSerializer as ms
import api.models as models
from api.utils import daily_price

from .models import (
    Author, Book, CreditCard, CustomUser, RentLogs,
    Payment, Comment)
from typing import Optional
from rest_framework.permissions import IsAuthenticated

   
class UserSerializer(ms):
    class Meta:
        model = CustomUser
        fields = ('username', 'password')
        extra_kwargs = {'password': {'write_only': True}}

#     def create(self, validated_data):
#         password = validated_data.pop('password')
#         user = CustomUser(**validated_data)
#         user.set_password(password)
#         user.save()
#         return user
    
#     def User_logout(request):

#         request.user.auth_token.delete()

#         LOGOUT(request)

#         return response('User Logged out successfully')


class UserUpdateSerializer(ms):
    username: Optional[str]
    first_name: Optional[str]
    last_name: Optional[str]
    email: Optional[int]
    is_staff: Optional[bool]
    is_active: Optional[bool]

    class Meta:
        model= CustomUser
        fields = ['name','surname']


class MemberSerializer(ms):
    class Meta:
        model= CustomUser
        exclude =['password']
        

class MemberUpdate(ms):
    username: Optional[str]
    first_name: Optional[str]
    last_name: Optional[str]
    email: Optional[int]
    is_staff: Optional[bool]
    is_active: Optional[bool]

    class Meta:
        model= CustomUser
        exclude= ['password']
        
class AuthorSerializer(ms):
    class Meta:
        model= Author
        fields= '__all__'
        
class AuthorUpdateSerializer(ms):
    name: Optional[str]
    last_name: Optional[str]
    biography: Optional[str]

    class Meta:
        model = Author
        fields = ['last_name']

class BookSerializer(ms):
    class Meta:
        model= Book
        fields= '__all__'
        permission_classes = [IsAuthenticated]

class BookUpdateSerializer(ms):
    author:     Optional[int]
    title:      Optional[str]
    genre:      Optional[str]
    stock:      Optional[int]
    page_number: Optional[str]
    publication_year:Optional[str]
    subject: Optional[str]
    daily_price: Optional[float]

    class Meta:
        model = Book
        fields = ['stock']

class RentSerializer(ms):
    class Meta:
        model= RentLogs
        exclude=['daily_price']

class RentOutputSerializer(ms):


    class Meta:
        model= RentLogs
        fields= '__all__'

class RentUpdateSerializer(ms):
    member: Optional[int]
    book: Optional[int]
    date: Optional[DateField]
    due: Optional[DateField]
    is_paid: Optional[bool]
    daily_price: Optional[float]

    class Meta:
        model= RentLogs
        fields=['due']        


class CreditCardSerializer(ms):
    class Meta:
        model= CreditCard
        fields= '__all__'

class CreditCardUpdateSerializer(ms):
    owner: Optional[int]
    credit_card: Optional[str]

    class Meta:
        model= CreditCard
        fields=['credit_card']

class PaymentOutputSerializer(ms):
    class Meta:
        model= Payment
        fields= '__all__'

class PaymentSerializer(ms):
    class Meta:
        model= Payment
        exclude= ['credit_card']

class PaymentInputSerializer(ms):
    class Meta:
        model= Payment
        exclude=['total_price']

class CommentSerializer(ms):
    class Meta:
        model= Comment
        fields= '__all__'

class CommentUpdateSerializer(ms):
    member: Optional[int]
    book: Optional[int]
    comment: Optional[str]
    date: Optional[DateField]

    class Meta:
        model = Comment
        fields = ['comment','comment_date']


class GroupOutputSerializer(ms):
    class Meta:
        model= CustomUser
        exclude= ['password']