import 'package:flutter/material.dart';
import 'package:cura_kefi/Views/Booking.dart';
import 'package:cura_kefi/Views/Appointments.dart';
import 'package:cura_kefi/Views/Med_Reports.dart';
import 'package:cura_kefi/Views/LabReports.dart';
import 'package:cura_kefi/Views/Radiology.dart';
import 'package:cura_kefi/Views/Prescriptions.dart';
import 'package:cura_kefi/Views/Bills.dart';
import 'package:cura_kefi/Views/Discharge.dart';

class MedicationsPage extends StatefulWidget {
  final int selectedIndex;
  const MedicationsPage({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<MedicationsPage> createState() => _MedicationsPageState();
}

class _MedicationsPageState extends State<MedicationsPage> {

  late int _selectedCategoryIndex;

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

  @override
  void initState() {
    super.initState();
    _selectedCategoryIndex = widget.selectedIndex;
  }

  void _onCategoryTap(int idx) {
    setState(() => _selectedCategoryIndex = idx);

    // Decide which page to open
    Widget nextPage;
    switch (idx) {
      case 0: nextPage = BookingPage(selectedIndex: 0); break;
      case 1: nextPage = AppointmentPage(selectedIndex: 1); break;
      case 2: nextPage = MedicationsPage(selectedIndex: 2); break;
      case 3: nextPage = MedReports(selectedIndex: 3); break;
      case 4: nextPage = LabReports(selectedIndex: 4); break;
      case 5: nextPage = RadiologyPage(selectedIndex: 5); break;
      case 6: nextPage = Prescriptions(selectedIndex: 6); break;
      case 7: nextPage = BillDetails(selectedIndex: 7); break;
      case 8: nextPage = DischargeDetails(selectedIndex: 8); break;
      default: nextPage = BookingPage(selectedIndex: 0);
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => nextPage));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => nextPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Medications'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal ChoiceChips
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(categories[i]),
                    selected: i == _selectedCategoryIndex,
                    onSelected: (_) => _onCategoryTap(i),
                    selectedColor: Colors.blue.shade100,
                    labelStyle: TextStyle(
                      color: i == _selectedCategoryIndex
                          ? Colors.blue.shade900
                          : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
