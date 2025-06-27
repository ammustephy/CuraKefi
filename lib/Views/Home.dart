// lib/Views/HomePage.dart

import 'package:cura_kefi/Provider/SwitchUser_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:cura_kefi/Provider/Home_Provider.dart';
import 'package:cura_kefi/Provider/Booking_Provider.dart';
import 'package:cura_kefi/Views/Notifications.dart';
import 'package:cura_kefi/Views/Appointments.dart';
import 'package:cura_kefi/Views/Profile.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = const FlutterSecureStorage();
  int _selectedIndex = 0;
  int _selectedCategoryIndex = -1;

  Future<void> _handleLogout() async {
    await storage.delete(key: 'token'); // Only remove token
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _onNavTap(int index) {
    switch (index) {
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const NotificationsPage()));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const AppointmentPage(selectedIndex: 1)));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ProfilePage()));
        break;
      default:
        setState(() => _selectedIndex = index);
    }
  }

  void _onCategoryTap(int index, Widget? page) {
    setState(() => _selectedCategoryIndex = index);
    if (page != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => page));
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeProv = context.watch<HomeProvider>();
    final userProv = context.watch<UserProvider>();
    final bookingProv = context.watch<BookingProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Search & switch account
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search doctor...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (v) => homeProv.search = v,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (userProv.accounts.length > 1)
                      IconButton(
                        onPressed: userProv.switchAccount,
                        icon: const Icon(Icons.switch_account),
                        tooltip: 'Switch account',
                      ),
                  ],
                ),
              ),
            ),
            // Banner
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/pic1.jpg',
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Active Appointments
            SliverToBoxAdapter(
              child: bookingProv.bookings.isEmpty
                  ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("No active appointments",
                    style: TextStyle(fontSize: 16)),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Active Appointments",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookingProv.bookings.length,
                    itemBuilder: (ctx, idx) {
                      final b = bookingProv.bookings[idx];
                      final isFirst = idx == 0;
                      return Card(
                        color:
                        isFirst ? Colors.blue.shade50 : null,
                        elevation: isFirst ? 6 : 2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        child: ListTile(
                          title: Text(
                            "${b.department} • ${b.slot} on ${DateFormat.yMMMEd().format(b.date)}",
                            style: TextStyle(
                                fontWeight:
                                isFirst ? FontWeight.bold : null),
                          ),
                          subtitle: Text(b.mode ==
                              AppointmentMode.online
                              ? 'Online'
                              : 'Offline'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                bookingProv.deleteBookingAt(idx),
                          ),
                          tileColor: isFirst
                              ? Colors.lightBlue
                              .withOpacity(0.1)
                              : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Categories Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, i) {
                    final cat = homeProv.categories[i];
                    final selected = i == _selectedCategoryIndex;
                    return GestureDetector(
                      onTap: () => _onCategoryTap(i, cat.page),
                      child: Card(
                        elevation: selected ? 8 : 2,
                        shadowColor:
                        selected ? Colors.blue.shade200 : Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: selected ? Colors.blue : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  cat.imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                cat.name,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: selected
                                        ? FontWeight.bold
                                        : null),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: homeProv.categories.length,
                ),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                  mainAxisExtent: 140,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
