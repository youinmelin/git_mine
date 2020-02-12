from django.db import models

# Create your models here.
class BookInfo(models.Model):
    '''图书模型类'''
    btitle = models.CharField(max_length = 20) #图书名称 字符串类型
    bpub_date = models.DateField() # 出版日期 日期类型

