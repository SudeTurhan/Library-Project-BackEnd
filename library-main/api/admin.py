from django.contrib import admin
from .models import *
# Register your models here.
admin.site.register(CustomUser)
admin.site.register(Book)
admin.site.register(RentLogs)
admin.site.register(Payment)
admin.site.register(Comment)
admin.site.register(Author)
admin.site.register(CreditCard)