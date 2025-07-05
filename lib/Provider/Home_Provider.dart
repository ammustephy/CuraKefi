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
        imageUrl: 'assets/images/Hbooking.png',
        page: BookingPage(selectedIndex: 0,)),
    Category(
        id: 'appointments',
        name: 'My Appointments',
        imageUrl: 'assets/images/HAppointment.png',
        page: AppointmentPage(selectedIndex: 1,)),
    Category(
        id: 'Medication',
        name: 'Active Medication',
        imageUrl: 'assets/images/Hmedicine.png',
        page: MedicationsPage(selectedIndex: 2,)),
    Category(
        id: 'medical',
        name: 'Medical Reports',
        imageUrl: 'assets/images/HMedreport.png',
        page: MedReports(selectedIndex: 3,)),
    Category(
        id: 'lab',
        name: 'Lab Reports',
        imageUrl: 'assets/images/Hlab.png',
        page: LabReports(selectedIndex: 4,)),
    Category(
        id: 'Radiology',
        name: 'Radiology Reports',
        imageUrl: 'assets/images/HRadiology.png',
        page: RadiologyPage(selectedIndex: 5,)),
    Category(
        id: 'prescriptions',
        name: 'Prescriptions',
        imageUrl: 'assets/images/Hprescription.png',
        page: Prescriptions(selectedIndex: 6,)),
    Category(
        id: 'Bills',
        name: 'Bill View',
        imageUrl: 'assets/images/Hbill.png',
        page: BillDetails(selectedIndex: 7,)),
    Category(
        id: 'Discharge',
        name: 'Discharge Summary',
        imageUrl: 'assets/images/HDischarge.png',
        page: DischargeDetails(selectedIndex: 8,)),
  ];

  String _search = '';
  String get search => _search;
  set search(String val) {
    _search = val;
    notifyListeners();
  }

}

