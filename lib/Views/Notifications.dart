// lib/Views/NotificationsPage.dart
import 'package:cura_kefi/Views/Appointments.dart';
import 'package:cura_kefi/Views/Home.dart';
import 'package:cura_kefi/Views/Profile.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _idx = 1; // Set to 1 since this is Notifications page

  void _onNav(int i) {
    if (i == _idx) return; // Already on this page

    switch (i) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
        break;
      case 1:
      // Already here, do nothing
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AppointmentPage(selectedIndex: 1)),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) =>  ProfilePage()),
        );
        break;
    }
    setState(() {
      _idx = i;
    });
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
      body: const Center(child: Text('No new notifications!')),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: PhysicalShape(
          elevation: 10,
          color: Colors.white,
          shadowColor: Colors.black38,
          clipper: const ShapeBorderClipper(shape: StadiumBorder()),
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: const ShapeDecoration(
              shape: StadiumBorder(),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (i) {
                const icons = [
                  Icons.home_filled,
                  Icons.notifications_active,
                  Icons.calendar_today,
                  Icons.person_outline,
                ];
                final active = _idx == i;
                return IconButton(
                  icon: Icon(icons[i], color: active ? Colors.black : Colors.grey),
                  onPressed: () => _onNav(i),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
