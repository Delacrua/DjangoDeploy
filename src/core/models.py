from django.db import models


class SampleModel(models.Model):
    attachment = models.FileField()
