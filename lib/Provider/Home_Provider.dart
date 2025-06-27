import 'package:cura_kefi/Views/Appointments.dart';
import 'package:cura_kefi/Views/Bills.dart';
import 'package:cura_kefi/Views/Discharge.dart';
import 'package:cura_kefi/Views/LabReports.dart';
import 'package:cura_kefi/Views/Med_Reports.dart';
import 'package:cura_kefi/Views/Medications.dart';
import 'package:cura_kefi/Views/Prescriptions.dart';
import 'package:cura_kefi/Views/Radiology.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:cura_kefi/Model/Category.dart';
import 'package:cura_kefi/Views/Booking.dart';

class HomeProvider with ChangeNotifier {
  final List<Category> categories = [
    Category(
        id: 'booking',
        name: 'Advance Appointment',
        imageUrl: 'assets/images/booking1.png',
        page: BookingPage(selectedIndex: 0,)),
    Category(
        id: 'appointments',
        name: 'My Appointments',
        imageUrl: 'assets/images/appointment1.png',
        page: AppointmentPage(selectedIndex: 1,)),
    Category(
        id: 'appointments',
        name: 'Active Medication',
        imageUrl: 'assets/images/Active Medication.png',
        page: MedicationsPage(selectedIndex: 2,)),
    Category(
        id: 'medical',
        name: 'Medical Reports',
        imageUrl: 'assets/images/medreport1.png',
        page: MedReports(selectedIndex: 3,)),
    Category(
        id: 'lab',
        name: 'Lab Reports',
        imageUrl: 'assets/images/labreport.png',
        page: LabReports(selectedIndex: 4,)),
    Category(
        id: 'lab',
        name: 'Radiology Reports',
        imageUrl: 'assets/images/Radiology Reports.png',
        page: RadiologyPage(selectedIndex: 5,)),
    Category(
        id: 'prescriptions',
        name: 'Prescriptions',
        imageUrl: 'assets/images/prescription.png',
        page: Prescriptions(selectedIndex: 6,)),
    Category(
        id: 'lab',
        name: 'Bill View',
        imageUrl: 'assets/images/Bills.png',
        page: BillDetails(selectedIndex: 7,)),
    Category(
        id: 'lab',
        name: 'Discharge Summary',
        imageUrl: 'assets/images/Discharge Summery.png',
        page: DischargeDetails(selectedIndex: 8,)),
  ];

  String _search = '';
  String get search => _search;
  set search(String val) {
    _search = val;
    notifyListeners();
  }

}

// Department list
  // final List<Departments> department = [
  //   Departments(id: 'dentistry', title: 'Dentistry', iconAsset: 'assets/images/dentistry.jpg'),
  //   Departments(id: 'cardio', title: 'Cardiology', iconAsset: 'assets/images/cardio2.jpg'),
  //   Departments(id: 'psychiatry', title: 'Psychiatry', iconAsset: 'assets/images/Psychiatry.jpg'),
  //   Departments(id: 'pediatrics', title: 'Pediatrics', iconAsset: 'assets/images/Pediatrics.jpg'),
  //   Departments(id: 'gynaecology', title: 'Gynaecology', iconAsset: 'assets/images/Gynaecology.jpg'),
  //   Departments(id: 'oncology', title: 'Oncology', iconAsset: 'assets/images/Oncology.png'),
  //   Departments(id: 'urology', title: 'Urology', iconAsset: 'assets/images/Urology.jpg'),
  //   Departments(id: 'general_surgery', title: 'General Surgery', iconAsset: 'assets/images/General Surgery1.png'),
  //   Departments(id: 'orthopedics', title: 'Orthopedics', iconAsset: 'assets/images/Orthopedics.jpg'),
  //   Departments(id: 'pulmonology', title: 'Pulmonology', iconAsset: 'assets/images/Pulmonology.jpg'),
  //   Departments(id: 'dermatology', title: 'Dermatology', iconAsset: 'assets/images/Dermatology.jpeg'),
  //   Departments(id: 'gastro', title: 'Gastroenterology', iconAsset: 'assets/images/Gastroenterology.jpg'),
  //   Departments(id: 'neurology', title: 'Neurology', iconAsset: 'assets/images/Neurology.png'),
  // ];

  // Categories list

// }
