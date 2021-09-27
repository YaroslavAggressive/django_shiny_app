from django.urls import path, include
# from .views import MedReportList
# from .views import MedReportView
from . import views
# from rest_framework import routers

# router = routers.DefaultRouter()
# router.register(r'med_reports', MedReportList.as_view())

urlpatterns = [
    path('med_reports/', views.reports_list),
    # path('med_reports/<int:pk>/', views.med_report_detail),
    # path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]