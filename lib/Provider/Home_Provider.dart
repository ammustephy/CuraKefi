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
        id: 'Medication',
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
        id: 'Radiology',
        name: 'Radiology Reports',
        imageUrl: 'assets/images/Radiology Reports.png',
        page: RadiologyPage(selectedIndex: 5,)),
    Category(
        id: 'prescriptions',
        name: 'Prescriptions',
        imageUrl: 'assets/images/prescription.png',
        page: Prescriptions(selectedIndex: 6,)),
    Category(
        id: 'Bills',
        name: 'Bill View',
        imageUrl: 'assets/images/billings.jpg',
        page: BillDetails(selectedIndex: 7,)),
    Category(
        id: 'Discharge',
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

