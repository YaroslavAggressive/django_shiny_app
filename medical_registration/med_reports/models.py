from django.db import models
from enum import Enum
from django.utils import timezone
from datetime import timedelta


class Diseases(Enum):
    FLU = "Flu"
    COVID = "Covid"
    CHICKENPOX = "Chickenpox"


class MedReport(models.Model):
    date = models.DateTimeField(default=timezone.now())
    disease = models.CharField(max_length=10, choices=[(e.value, e.value) for e in Diseases])
    patients = models.CharField(max_length=20)

    # class Meta:
    #     ordering = ['created']



