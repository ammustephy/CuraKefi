// lib/Views/Login.dart
import 'dart:ui';
import 'dart:math' as math;
import 'package:cura_kefi/Styles.dart';
import 'package:flutter/material.dart';
import 'package:cura_kefi/Api_Services.dart';
import 'package:glassmorphism/glassmorphism.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool _isHidden = true;

  Future<void> _handleLogin() async {
    setState(() => isLoading = true);
    try {
      final result = await login(
        uid: idController.text,
        mobile: passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again.')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: -w * .3, left: -w * .3, child: Styles.topWidget(w)),
          Positioned(bottom: -w * .4, right: -w * .4, child: Styles.bottomWidget(w)),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GlassmorphicContainer(
                width: double.infinity,
                height: 380,
                borderRadius: 20,
                blur: 20,
                alignment: Alignment.center,
                border: 1,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ],
                  stops: const [0.1, 1],
                ),
                borderGradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.5),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image.asset(
                      //   'assets/images/logo-Kefi_Cura.png',
                      //   height: 80,
                      //   width: 80,
                      // ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: idController,
                        decoration: InputDecoration(
                          hintText: 'Enter UID',
                          prefixIcon: const Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isHidden ? Icons.visibility_off : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () => setState(() => _isHidden = !_isHidden),
                          ),
                        ),
                        // obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Sign In", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
