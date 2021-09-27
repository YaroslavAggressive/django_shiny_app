from rest_framework import generics
from rest_framework.decorators import api_view
from .models import MedReport
from .serializers import MedReportSerializer
from rest_framework.response import Response
from rest_framework import status


# class MedReportView(generics.CreateAPIView):
#     model = MedReport
#     serializer_class = MedReportSerializer


# class MedReportList(generics.ListCreateAPIView):
#
#     queryset = MedReport.objects.all()
#     serializer_class = MedReportSerializer


@api_view(['GET', 'POST'])
def reports_list(request):

    if request.method == 'GET':
        reports = MedReport.objects.all()
        serializer = MedReportSerializer(reports, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        serializer = MedReportSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)




