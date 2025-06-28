// lib/Views/Login.dart
import 'dart:ui';
import 'package:cura_kefi/Api_Services.dart';
import 'package:cura_kefi/Provider/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

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
    setState(() {
      isLoading = true;
    });
    try {
      final result = await login(
        uid: idController.text,
        mobile: passwordController.text, // consider renaming "mobile" to "password"
      );
      // Optionally, check result.success here
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(children: [
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GlassmorphicContainer(
              width: double.infinity,
              height: 600,
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
              borderGradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.5),
              ]),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(height: 16),
                  TextField(
                    controller: idController,
                    enabled: !isLoading,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Enter UID',
                      prefixIcon: const Icon(Icons.person),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    enabled: !isLoading,
                    obscureText: _isHidden,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isHidden ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black54,
                        ),
                        onPressed: () =>
                            setState(() => _isHidden = !_isHidden),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: auth.loading
                          ? null
                          : () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          content: Text(
                              'Forgot password not implemented'))),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.teal,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                          color: Colors.white)
                          : const Text("Sign In",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 150,
          child: Row(children: [
            Image.asset('assets/images/logo-Kefi_Cura.png',
                height: 50, width: 30),
            const SizedBox(width: 8),
            Text('Kefi', style: TextStyle(fontSize: 18,color: Colors.blue.shade900)),
            Text('Cura',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.orange.shade900),)
          ]),
        ),
      ]),
    );
  }
}
