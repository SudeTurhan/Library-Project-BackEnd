from collections import UserDict
from contextvars import Token
from dataclasses import fields


from django.db import IntegrityError
from django.forms import ValidationError
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.permissions import IsAuthenticated



from .serializers import (
    BookSerializer, GroupOutputSerializer, MemberUpdate, RentOutputSerializer, RentSerializer, 
    UserSerializer, CommentSerializer, CreditCardSerializer,
    PaymentSerializer,PaymentInputSerializer,AuthorSerializer,MemberSerializer,
    CreditCardUpdateSerializer, RentUpdateSerializer,PaymentOutputSerializer,
    AuthorUpdateSerializer,BookUpdateSerializer,CommentUpdateSerializer, UserUpdateSerializer)

from .models import (
    Author, Book, CreditCard, RentLogs, CustomUser, Comment, Payment
)

from .utils import(
    daily_price,book_stock_change, payment_cost, payment_cost_two, decrease
)
# Create your views here.
class CustomUserList(APIView):
    def get(self,request,format=None):
        users=CustomUser.objects.all()
        serializer= UserSerializer(users, many= True)
        return Response(serializer.data)

    def post(self, request, format=None):
        serializer=  UserSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status= status.HTTP_201_CREATED)
        return Response(serializer.errors, status= status.HTTP_400_BAD_REQUEST)

class CustomUserDetail(APIView):
    @api_view(['GET','PUT','DELETE'])
    def customer_upd_del(request, pk):
        user_instance = CustomUser.objects.get(pk=pk)
        if request.method =='GET':
            serializer=UserSerializer(user_instance)
            return Response(serializer.data)
        elif request.method =='PUT':
            serializer = UserSerializer(user_instance, data = request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data)   
            return Response(status=status.HTTP_400_BAD_REQUEST)
        elif request.method == 'DELETE':
            user_instance.delete()
            return Response( status=status.HTTP_204_NO_CONTENT) 


# from rest_framework.permissions import AllowAny, IsAdminUser
# from rest_framework import permissions
# from rest_framework.views import APIView
# from rest_framework.decorators import api_view, permission_classes
# @api_view(["POST"])
# @permission_classes([AllowAny])
# def Register_Users(request):
#     try:
#         data = []
#         serializer = RegistrationSerializer(data=request.data)
#         if serializer.is_valid():
#             account = serializer.save()
#             account.is_active = True
#             account.save()
#             token = Token.objects.get_or_create(user=account)[0].key
#             data["message"] = "user registered successfully"
#             data["email"] = account.email
#             data["username"] = account.username
#             data["token"] = token

#         else:
#             data = serializer.errors


#         return Response(data)
#     except IntegrityError as e:
#         account=UserDict.objects.get(username='')
#         account.delete()
#         raise ValidationError({"400": f'{str(e)}'})

#     except KeyError as e:
#         print(e)
#         raise ValidationError({"400": f'Field {str(e)} missing'})

#----------------------------------------------------------------
# from rest_framework.permissions import AllowAny
# from rest_framework.generics import CreateAPIView
# from django.views.decorators.csrf import csrf_exempt


# class UserCreate(CreateAPIView):
#     queryset = CustomUser.objects.all()
#     serializer_class = UserSerializer
#     permission_classes = (AllowAny, )

# from rest_framework import status
# from rest_framework.response import Response
# from rest_framework.views import APIView

# class Logout(APIView):
#     def get(self, request, format=None):
#         # simply delete the token to force a login
#         request.user.auth_token.delete()
#         return Response(status=status.HTTP_200_OK)


from django.core import serializers
import json
class MemberList(APIView):
    def get(self,request,group,format=None):
        users = CustomUser.objects.filter(groups__name=group)
        serializer= serializers.serialize(
            'json', list(users), fields= (
                "username", "first_name", "last_name", "email"
            ))
        serializer= json.loads(serializer)
        if serializer:
            return Response(serializer)
        else:
            return Response("Not found")


    def post(self, request, format=None):
        serializer=  UserSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status= status.HTTP_201_CREATED)
        return Response(serializer.errors, status= status.HTTP_400_BAD_REQUEST)


class MemberDetail(APIView):
   
    def get(self, request,group, pk, format=None):
        user_instance = CustomUser.objects.filter(groups__name=group,pk=pk)
        print(user_instance)
    
        serializer= serializers.serialize(
        'json', list(user_instance), fields= (
            "username", "first_name", "last_name", "email"
        ))
        serializer= json.loads(serializer)
        return Response(serializer)

    def put(self, request, pk, format=None):
        user_upd = CustomUser.objects.get(pk=pk)
        serializer = MemberUpdate(user_upd,data= request.data)
        # print(serializer)
        
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk, format=None):
        transformer = CustomUser.objects.get(pk=pk)
        transformer.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

   
    



class AuthorList(APIView):
    def get(self, request, format=None):
        authors= Author.objects.all()
        serializer= AuthorSerializer(authors, many= True)
        return Response(serializer.data)
    
    def post(self, request, format=None):
        serializer= AuthorSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status= status.HTTP_201_CREATED)
        return Response(serializer.errors, status= status.HTTP_400_BAD_REQUEST)

class AuthorDetail(APIView):
    
    @api_view(['GET','PUT','DELETE'])
    def author_upd_del(request, pk):
        author_instance = Author.objects.get(pk=pk)

        if request.method =='GET':

            serializer=AuthorSerializer(author_instance)
            return Response(serializer.data)
        elif request.method =='PUT':

            serializer = AuthorUpdateSerializer(author_instance, data = request.data)

            if serializer.is_valid():

                serializer.save()
                return Response(serializer.data)   
            return Response(status=status.HTTP_400_BAD_REQUEST)
        elif request.method == 'DELETE':
            author_instance.delete()
            return Response( status=status.HTTP_204_NO_CONTENT) 

    @api_view(['GET'])
    def get_lastname(request, last_name):
        yazarlar = Author.objects.all().filter(last_name=last_name)
        serializer= AuthorSerializer(yazarlar,  many=True, context={'request': request})
        return Response(serializer.data)
  



class BookList(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, format= None):
        queryset= Book.objects.all()
        serializer= BookSerializer(queryset, many= True)
        return Response(serializer.data)
    
    def post(self, request, format= None):
        serializer= BookSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status= status.HTTP_201_CREATED)
        return Response(serializer.errors, status= status.HTTP_400_BAD_REQUEST)

class BookDetail(APIView):
    permission_classes = [IsAuthenticated]
    @api_view(['GET'])
    def get( request):

        books = Book.objects.all()
        serializer = BookSerializer(books, many=True)
        return Response(serializer.data)

    @api_view(['GET','PUT','DELETE'])
    def book_update_del(request, pk):
        book_instance = Book.objects.filter(pk=pk)
        if request.method == 'GET':
            serializer = BookSerializer(book_instance, many=False)
            return Response(serializer.data)
        elif request.method =='PUT':
            serializer = BookUpdateSerializer(book_instance, data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data)
            return Response(status=status.HTTP_400_BAD_REQUEST)
        elif request.method == 'DELETE':
            book_instance.delete()
            return Response( status=status.HTTP_204_NO_CONTENT)


    @api_view(['GET'])
    def get_book_pk( request,pk):
        books = Book.objects.get(pk=pk)

        if books:
            serializer = BookSerializer(books)
            return Response(serializer.data)
        else:
            return Response(status = status.HTTP_404_NOT_FOUND)

    @api_view(['GET'])
    def get_book_kind(request,kind):
        book_instance = Book.objects.all().filter(kind=kind)
        
        if book_instance:
            serializer= BookSerializer(book_instance,  many=True)
            return Response(serializer.data)
        else:
            return HttpResponse("Not found")

    @api_view(['GET'])
    def get_book_publication_year(request,publication_year):
        book_instance = Book.objects.filter(publication_year__gt = publication_year)
        serializer = BookSerializer(book_instance,  many=True)
        if book_instance.exists():
            return Response(serializer.data)
        else:
            return Response("Not found",status=status.HTTP_404_NOT_FOUND)

    @api_view(['GET'])
    def get_stock(request):
        book_instance = Book.objects.all().filter(stock__gte = 1)
        stock = BookSerializer(book_instance, many=True)
        if (stock):
            return Response(stock.data)
        else:
            return HttpResponse("No book in stock!")

    @api_view(['GET'])
    def get_no_stock(request):
        book_instance = Book.objects.filter(stock__exact = 0)
        serializer = BookSerializer(book_instance,  many=True)
        if book_instance.exists():

            return Response(serializer.data)
        else:
            return HttpResponse("All books are available!")


class CommentList(APIView):
    def get(self, request, format= None):
        queryset= Comment.objects.all()
        serializer= CommentSerializer(queryset, many= True)
        return Response(serializer.data)
    
    def post(self, request, format= None):
        serializer= CommentSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status= status.HTTP_201_CREATED)
        return Response(serializer.errors, status= status.HTTP_400_BAD_REQUEST)

class CommentDetail(APIView):

    @api_view(['GET','PUT','DELETE'])
    def comment_update_del(request, pk):
        comment_instance = Comment.objects.filter(pk=pk)
        if request.method == 'GET':
            serializer = CommentSerializer(comment_instance, many=True)
            return Response(serializer.data)
        elif request.method =='PUT':
            serializer = CommentUpdateSerializer(comment_instance, data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data)
            return Response(status=status.HTTP_400_BAD_REQUEST)
        elif request.method == 'DELETE':
            comment_instance.delete()
            return Response( status=status.HTTP_204_NO_CONTENT)


    @api_view(['GET'])
    def get_comment_book(request, book):
        comment_instance = Comment.objects.filter(book= book)
        serializer = CommentSerializer(comment_instance, many=True)
        if comment_instance.exists():

            return Response(serializer.data)
        else:
            return Response("No comment, yet!",status=status.HTTP_404_NOT_FOUND)

    @api_view(['GET'])
    def get_member_comment(request,member):
        comment_instance = Comment.objects.filter(member=member)
        serializer = CommentSerializer(comment_instance, many=True)
        if comment_instance.exists():
            return Response(serializer.data)
        else:
            return Response("The member has not commented yet.",status=status.HTTP_404_NOT_FOUND)




class RentList(APIView):
    def get(self, request, format= None):
        queryset= RentLogs.objects.all()
        serializer= RentOutputSerializer(queryset, many= True)
        return Response(serializer.data)
    
    def post(self, request, format= None):
        try:
            serializer= RentSerializer(data= request.data)
            if serializer.is_valid():
                total_price= daily_price(serializer.validated_data['book'])
                book_stock_change(serializer.validated_data['book'])
                serializer.validated_data['daily_price'] = total_price            
                serializer.save()
            
                augmented_serializer_data = serializer.data
                augmented_serializer_data['price']= total_price

                return Response(augmented_serializer_data)
            return Response(serializer.errors, status= status.HTTP_201_CREATED)
        except Exception as e:
            return Response(str(e), status= status.HTTP_400_BAD_REQUEST)


class RentDetail(APIView):
    @api_view(['GET','PUT','DELETE'])
    def rent_upd_del(request, pk):
        rent_instance = RentLogs.objects.get(pk=pk)
        if request.method =='GET':
            serializer=RentOutputSerializer(rent_instance)
            return Response(serializer.data)
        elif request.method =='PUT':
            serializer = RentUpdateSerializer(rent_instance, data = request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data)   
            return Response(status=status.HTTP_400_BAD_REQUEST)
        elif request.method == 'DELETE':
            rent_instance.delete()
            return Response( status=status.HTTP_204_NO_CONTENT) 


class CreditCardList(APIView):
    def get(self, request, format=None):
        authors= CreditCard.objects.all()
        serializer= CreditCardSerializer(authors, many= True)
        return Response(serializer.data)
    
    def post(self, request, format=None):
        serializer= CreditCardSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status= status.HTTP_201_CREATED)
        return Response(serializer.errors, status= status.HTTP_400_BAD_REQUEST)

class CreditCardDetail(APIView):
    
    @api_view(['GET','PUT','DELETE'])
    def card_upd_del(request, pk):
        card_instance = CreditCard.objects.get(pk=pk)
        if request.method =='GET':
            serializer=CreditCardSerializer(card_instance)
            return Response(serializer.data)
        elif request.method =='PUT':
            serializer = CreditCardUpdateSerializer(card_instance, data = request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data)   
            return Response(status=status.HTTP_400_BAD_REQUEST)
        elif request.method == 'DELETE':
            card_instance.delete()
            return Response( status=status.HTTP_204_NO_CONTENT) 
    


class PaymentList(APIView):
    def get(self, request, format= None):
        queryset= Payment.objects.all()
        serializer= PaymentSerializer(queryset, many= True)
        return Response(serializer.data)

    def post(self, request, format= None):
        payment_serializer= PaymentInputSerializer(data= request.data)
        if payment_serializer.is_valid():
            rent_id= payment_serializer.validated_data['process'].id
            print(type(rent_id))
            rent_data= RentLogs.objects.get(pk= rent_id)
            print(rent_data)
            payment_serializer.validated_data["total_price"]= payment_cost_two(rent_data)
            print(payment_serializer.validated_data)
            payment_serializer.save()
            rent_data.is_paid = True
            rent_data.save()
            #books_list= RentLogs.book.through.objects.filter(rentlogs_id= rent_data.book).select_related
            books_list= RentLogs.book.through.objects.filter(rentlogs_id= rent_id)
            decrease(books_list)
            return Response(rent_id)
        return Response(payment_serializer.errors)

class PaymentDetail(APIView):
    @api_view(['GET','PUT','DELETE'])
    def payment_upd_del(request, pk):
        payment_instance = Payment.objects.get(pk=pk)
        if request.method =='GET':
            serializer=PaymentOutputSerializer(payment_instance)
            return Response(serializer.data)
        elif request.method =='PUT':
            serializer = PaymentOutputSerializer(payment_instance, data = request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data)   
            return Response(status=status.HTTP_400_BAD_REQUEST)
        elif request.method == 'DELETE':
            payment_instance.delete()
            return Response( status=status.HTTP_204_NO_CONTENT)



