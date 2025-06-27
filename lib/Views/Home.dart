// lib/Views/HomePage.dart
import 'dart:math' as math;
import 'dart:ui';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:cura_kefi/Styles.dart';
import 'package:cura_kefi/Provider/Home_Provider.dart';
import 'package:cura_kefi/Provider/Booking_Provider.dart';
import 'package:cura_kefi/Provider/SwitchUser_Provider.dart';
import 'package:cura_kefi/Views/Notifications.dart';
import 'package:cura_kefi/Views/Appointments.dart';
import 'package:cura_kefi/Views/Profile.dart';
import 'package:intl/intl.dart';

class _GlassBar extends StatefulWidget {
  final Widget child;
  const _GlassBar({required this.child});

  @override
  State<_GlassBar> createState() => _GlassBarState();
}

class _GlassBarState extends State<_GlassBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = const FlutterSecureStorage();
  int _idx = 0, _catIdx = -1;

  Future<void> _logout() async {
    await storage.delete(key: 'token');
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _onNav(int i) {
    setState(() => _idx = i);
    switch (i) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AppointmentPage(selectedIndex: 1)));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) =>  ProfilePage()));
        break;
      case 0:
      default:
        break;
    }
  }

  void _onCat(int i, Widget? page) {
    setState(() => _catIdx = i);
    if (page != null) Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final homeProv = context.watch<HomeProvider>();
    final userProv = context.watch<UserProvider>();
    final bookProv = context.watch<BookingProvider>();

    return Scaffold(
      extendBody: true,
      body: Stack(children: [
        Positioned(top: -w * 0.3, left: -w * 0.3, child: Styles.topWidget(w)),
        Positioned(bottom: -w * 0.4, right: -w * 0.4, child: Styles.bottomWidget(w)),
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _GlassBar(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search doctor...',
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (v) => homeProv.search = v,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (userProv.accounts.length > 1)
                          IconButton(onPressed: userProv.switchAccount, icon: const Icon(Icons.switch_account)),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/pic1.jpg',
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: bookProv.bookings.isEmpty
                    ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("No active appointments", style: TextStyle(fontSize: 16)),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Active Appointments",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...bookProv.bookings.mapIndexed((idx, b) {
                      final first = idx == 0;
                      return Card(
                        color: first ? Colors.blue.shade50 : null,
                        elevation: first ? 6 : 2,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: ListTile(
                          title: Text(
                            "${b.department} • ${b.slot} on ${DateFormat.yMMMEd().format(b.date)}",
                            style: TextStyle(fontWeight: first ? FontWeight.bold : null),
                          ),
                          subtitle: Text(b.mode == AppointmentMode.online ? 'Online' : 'Offline'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => bookProv.deleteBookingAt(idx),
                          ),
                          tileColor: first ? Colors.lightBlue.withOpacity(0.1) : null,
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (_, i) {
                      final cat = homeProv.categories[i];
                      final sel = i == _catIdx;
                      return GestureDetector(
                        onTap: () => _onCat(i, cat.page),
                        child: Card(
                          elevation: sel ? 8 : 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: sel ? Colors.blue : Colors.transparent, width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(cat.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                cat.name,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontWeight: sel ? FontWeight.bold : null),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: homeProv.categories.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 140,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: PhysicalShape(
          elevation: 10,
          color: Colors.white,
          shadowColor: Colors.black38,
          clipper: const ShapeBorderClipper(
            shape: StadiumBorder(),
          ),
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: ShapeDecoration(
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
