from django.db import models
from django.contrib.auth.models import AbstractUser
from django.conf import settings
from django.utils.translation import gettext_lazy as choice

from django.contrib.auth.models import Group

class PaymentChoices(models.TextChoices):
    CASH        = "Cash"  , choice("Cash")
    CREDITCARD  = "Credit Card"  , choice("Credit Card")

# Create your models here.

class CustomUser(AbstractUser):
    pass

class Author(models.Model):
    name=models.CharField(max_length=120)
    last_name = models.CharField(max_length=120)
    biography = models.TextField(blank=True, null=True)



class Book(models.Model):
    author           = models.ForeignKey(Author, on_delete=models.CASCADE, related_name='authors')
    title            = models.CharField(max_length=120)
    genre            = models.CharField(max_length=100)
    stock            = models.IntegerField()
    #env\Lib\site-packages\django\db\models\fields\__init__.py line 2059
    page_number      = models.CharField(max_length=2000)
    publication_year = models.CharField(max_length=4)
    subject          = models.TextField(blank=True, null=True)
    daily_price      = models.FloatField()

class RentLogs(models.Model):
    member = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)
    book = models.ManyToManyField(Book)
    date = models.DateField(auto_now= True)
    due=    models.DateField()
    is_paid= models.BooleanField(default= False)
    daily_price= models.FloatField()

class CreditCard(models.Model):
    owner           = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    credit_card     = models.CharField(max_length= 20)


class Payment(models.Model):
    process= models.ForeignKey(
        RentLogs, on_delete= models.CASCADE,
            limit_choices_to= {
        'is_paid': False
        },
    )
    method=models.CharField(choices=PaymentChoices.choices, default=PaymentChoices.CASH, max_length= 20)
    credit_card= models.ForeignKey(CreditCard,on_delete=models.CASCADE, null= True, blank= True)
    total_price = models.IntegerField()
    date=models.DateTimeField(auto_now=True)


class Comment(models.Model):
    member= models.ForeignKey(settings.AUTH_USER_MODEL, on_delete= models.CASCADE)
    book = models.ForeignKey(Book, on_delete=models.CASCADE)
    comment = models.TextField()
    date=models.DateField(auto_now=True)