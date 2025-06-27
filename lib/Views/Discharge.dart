import 'package:flutter/material.dart';
import 'package:cura_kefi/Views/Booking.dart';
import 'package:cura_kefi/Views/Appointments.dart';
import 'package:cura_kefi/Views/Medications.dart';
import 'package:cura_kefi/Views/Med_Reports.dart';
import 'package:cura_kefi/Views/LabReports.dart';
import 'package:cura_kefi/Views/Radiology.dart';
import 'package:cura_kefi/Views/Prescriptions.dart';
import 'package:cura_kefi/Views/Bills.dart';

class DischargeDetails extends StatefulWidget {
  final int selectedIndex;
  const DischargeDetails({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<DischargeDetails> createState() => _DischargeDetailsState();
}

class _DischargeDetailsState extends State<DischargeDetails> {
  int _selectedCategoryIndex = 8;

  final categories = [
    'Advance Appointments',
    'My Appointments',
    'Active Medication',
    'Medical Reports',
    'Lab Reports',
    'Radiology Reports',
    'Prescriptions',
    'Bill View',
    'Discharge Summary',
  ];

  void _onCategoryTap(int idx) {
    setState(() => _selectedCategoryIndex = idx);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      switch (idx) {
        case 0: return  BookingPage(selectedIndex: 0,);
        case 1: return  AppointmentPage(selectedIndex: 1,);
        case 2: return  MedicationsPage(selectedIndex: 2,);
        case 3: return  MedReports(selectedIndex: 3,);
        case 4: return  LabReports(selectedIndex: 4,);
        case 5: return  RadiologyPage(selectedIndex: 5,);
        case 6: return  Prescriptions(selectedIndex: 6,);
        case 7: return  BillDetails(selectedIndex: 7,);
        case 8: return  DischargeDetails(selectedIndex: 8,);
        default: return  BookingPage(selectedIndex: 0,);
      }
    }
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Discharge Summary', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 🟦 ChoiceChip Selector
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final isSelected = i == _selectedCategoryIndex;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(categories[i]),
                    selected: isSelected,
                    onSelected: (_) => _onCategoryTap(i),
                    selectedColor: Colors.blue.shade100,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.blue.shade900 : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          ]
        ),
      ),
    );
  }
}
