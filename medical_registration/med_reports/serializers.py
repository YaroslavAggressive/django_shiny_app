from rest_framework import serializers
from .models import MedReport


class MedReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = MedReport
        fields = ("date", "disease", "patients")



