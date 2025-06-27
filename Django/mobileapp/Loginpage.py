from rest_framework.views import APIView
from apps.accounts.models import *
from rest_framework import status, permissions
from rest_framework.response import Response
from django.db import IntegrityError


class HospitalView(APIView):
    
    def get(self, request):
        try:
            """API For Listing Hospitals"""
            hospitalname = Hospital.objects.values_list('name', flat=True)

            return Response({
                "status": "success",
                "message": "Hospitals fetched successfully",
                "data": {
                    "hospitalname": hospitalname,
                }
            }, status=status.HTTP_201_CREATED)
            
        except IntegrityError as e:
            error_message = "No Hospital Found"
  
            return Response({
                "status": "error",
                "message": error_message
            }, status=status.HTTP_400_BAD_REQUEST)
            
        except Exception as e:
            return Response({
                "status": "error",
                "message": f"An error occurred: {str(e)}"
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
class LoginPatientDetails(APIView):
    """API For Listing Patient Details after login"""
    # permission_classes = [IsAuthenticated]  # Uncomment and adjust as needed
    
    def post(self, request):
        try:
            number = request.data.get('mobile')
            patient_details = PatientRegistration.objects.filter(contact_number=number).values_list('first_name', flat=True)

            
            return Response({
                "patientdetails": patient_details
            }, status=status.HTTP_200_OK)
            
        except Exception as e:
            return Response({
                "status": "error",
                "message": f"An error occurred: {str(e)}"
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
 
class DepartmentList(APIView):
    """API For Listing Departments"""
    # permission_classes = [IsAuthenticated]  # Uncomment and adjust as needed
    
    def get(self, request):
        """Get list of all departments"""
        try:
            dept_name = Department.objects.order_by('name').values_list('name', flat=True)
            
            return Response({
                "departments": dept_name
            }, status=status.HTTP_200_OK)
            
        except Exception as e:
            return Response({
                "status": "error",
                "message": f"An error occurred: {str(e)}"
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
class DoctorList(APIView):
    """API For Listing Doctors"""
    # permission_classes = [IsAuthenticated]  # Uncomment and adjust as needed
    
    def post(self, request):
        """Get list of all Doctors based on department"""
        try:
            dept_name = request.data.get('dept')
            doctorlist = Department.objects.filter(name=dept_name).values_list("head__user__username",flat=True)
                    
            return Response({
                "doctorlist": doctorlist
            }, status=status.HTTP_200_OK)
            
        except Exception as e:
            return Response({
                "status": "error",
                "message": f"An error occurred: {str(e)}"
            }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    