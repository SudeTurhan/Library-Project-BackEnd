"""library URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from api import views
from django.urls import path,include
from django.views.decorators.csrf import csrf_exempt
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)


urlpatterns = [
    path('admin/', admin.site.urls),
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    # path('api-auth/', include('rest_framework.urls')),
    # path('api-auth/logout/', views.Logout.as_view()),
    # path('account/register', views.UserCreate.as_view()),

    path('authors/', views.AuthorList.as_view(), name= 'author-list'),
    path('authors/<int:pk>/', views.AuthorDetail.author_upd_del, name= 'author-update-delete'),
    path('author/lastname/<str:last_name>/', views.AuthorDetail.get_lastname, name= 'author-list-detail'),
    
    path('users/', views.CustomUserList.as_view(), name= 'user-list'),
    path('user/<int:pk>/', views.CustomUserDetail.customer_upd_del, name= 'user-list'),

    path('users/<str:group>/', views.MemberList.as_view(), name= 'member-list'),
    path('users/<str:group>/<int:pk>', views.MemberDetail.as_view(), name= 'member-upd-del-list'),
    
    path('books/', views.BookList.as_view(), name= 'book-list'),
    path('books/upd_del/<int:pk>', views.BookDetail.book_update_del, name= 'book-upd-del'),
    path('books/<int:pk>/', views.BookDetail.get_book_pk, name= 'id-book-list'),
    path('books/stock/', views.BookDetail.get_stock, name= 'stock-book-list'),
    path('books/nostock/', views.BookDetail.get_no_stock, name= 'no-stock-book-list'),
    path('books/kind/<str:kind>/', views.BookDetail.get_book_kind, name= 'kind-book-list'),
    path('books/pubyear/<int:publication_year>', views.BookDetail.get_book_publication_year, name= 'book_publication_year'),
    
    path('comments/', views.CommentList.as_view(), name= 'comment-list'),
    path('comments/book/<int:book>', views.CommentDetail.get_comment_book, name= 'comment-list'),
    path('comments/member/<int:member>', views.CommentDetail.get_member_comment, name= 'member-comment-list'),
    path('comments/upd_del/<int:pk>', views.CommentDetail.comment_update_del, name= 'comment-upd-del-list'),
    
    path('rentlog/', views.RentList.as_view(), name= 'rent-list'),
    path('rentlog/<int:pk>', views.RentDetail.as_view(), name= 'rent-upd-del-list'),
    
    path('creditcards/', views.CreditCardList.as_view(), name= 'creditcard-list'),
    path('creditcards/<int:pk>', views.CreditCardDetail.card_upd_del, name= 'creditcard-detail-list'),

    path('api/payment/<int:pk>',views.PaymentDetail.as_view()),
    path('api/payment/',views.PaymentList.as_view()),


]

