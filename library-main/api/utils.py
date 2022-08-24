from argparse import ArgumentError
from datetime import datetime
from xmlrpc.client import ResponseError
from django.forms import DateTimeField
from django.http import HttpResponseBadRequest
from rest_framework.response import Response
from rest_framework import status
from rest_framework import serializers 
from .models import (Book, RentLogs,Payment)
DEFAULT = 3

class InvalidArgumentError(ValueError):
    

    def __init__(self, message="The book is out of stock"):
        self.message = message
        super().__init__(self.message)


# def calculate_daily_cost(object):
#     # books= object["book"]
#     return (DEFAULT * object)

# def book_availability(id):
#     stock= Book.objects.get(pk= id).stock
#     return stock


def daily_price(*args):
    sum=0
    for books in args:
        for book in books:
            id= book.id
            sum = sum + Book.objects.get(pk= id).daily_price
    return sum


def book_stock_change( *args):
    for books in args:
        for book in books:
            id = book.id
            #query set
            data= Book.objects.get(pk= id)
            if data.stock == 0:
                raise InvalidArgumentError()
            data.stock -=  1
            data.save()

def decrease( *args):
        for books in args:
            for book in books:
                book= book.book
                book.stock += 1
                book.save()

def payment_cost(id):   
        rent_date         = RentLogs.objects.get(pk=id).date
        delivery_deadline = RentLogs.objects.get(pk=id).due
        daily_price       = RentLogs.objects.get(pk=id).daily_price
        is_paid           = RentLogs.objects.get(pk=id).is_paid
        current           = datetime.now().date()
        delta             = (delivery_deadline - rent_date).days
        price             = delta * daily_price
        if (current > delivery_deadline):
            price  = (price + ((current - delivery_deadline) * 2 * daily_price))
        return price
from django.db.models import Model
def payment_cost_two(rent_object: Model):   
        rent_date         = rent_object.date
        delivery_deadline = rent_object.due
        daily_price       = rent_object.daily_price
        current           = datetime.now().date()
        delta             = (delivery_deadline - rent_date).days
        price             = delta * daily_price
        if (current > delivery_deadline):
            price  = (price + ((current - delivery_deadline) * 2 * daily_price))
        return price