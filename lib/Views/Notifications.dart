import 'package:cura_kefi/Views/Appointments.dart';
import 'package:cura_kefi/Views/Home.dart';
import 'package:flutter/material.dart';
import 'package:cura_kefi/Views/Profile.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _selectedIndex = 1; // Notifications tab index

  void _onNavTap(int index) {
    if (index == _selectedIndex) return;

    setState(() => _selectedIndex = index);

    // Navigate based on index
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage())); // Replace with HomePage
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NotificationsPage()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AppointmentPage(selectedIndex: 1,)));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notifications', style: TextStyle(color: Colors.black)),
      ),
      body: const Center(child: Text('🎉 No new notifications!')), // Replace with your content
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
