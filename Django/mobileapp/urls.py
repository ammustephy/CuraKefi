from django.urls import path
from .views import *  # Import directly
from .Loginpage import *

urlpatterns = [
path('hospital-list', HospitalView.as_view(), name='hospital-list'),
path('dept-list', DepartmentList.as_view(), name='dept-list'),
path('doc-list', DoctorList.as_view(), name='doc-list'),
path('patient-details', LoginPatientDetails.as_view(), name='patient-details'),

]