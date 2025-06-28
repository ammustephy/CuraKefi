// lib/Views/SplashPage.dart
import 'dart:async';
import 'dart:ui'; // ← Import for ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cura_kefi/Styles.dart'; // ← Assuming Styles has topWidget/bottomWidget

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  late final AnimationController _ctrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..forward();
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(_ctrl);

    Timer(const Duration(seconds: 2), _checkLogin);
  }

  Future<void> _checkLogin() async {
    final token = await storage.read(key: 'token');
    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        (token != null && token.isNotEmpty) ? '/home' : '/login',
      );
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width; // Get width for positioning

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Positioned(top: -w*0.3, left: -w*0.3, child: Styles.topWidget(w)),
          // Positioned(bottom: -w*0.4, right: -w*0.4, child: Styles.bottomWidget(w)),
          FadeTransition(
            opacity: _fadeAnim,
            child: const _SplashContent(),
          ),
        ],
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo-Kefi_Cura.png', width: 120, height: 120),
            const SizedBox(height: 8),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Text('Kefi', style: TextStyle(fontSize: 25, color: Colors.blue.shade900)),
              Text('Cura', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.orange.shade900)),
            ]),
            const SizedBox(height: 16),
            Text(
              'Hospital Management System',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.blue.shade900),
            ),
          ],
        ),
      ),
    );
  }
}
