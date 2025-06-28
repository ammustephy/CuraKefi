import 'dart:convert';
import 'dart:async';
import 'package:cura_kefi/Views/Home.dart';
import 'package:cura_kefi/Views/Splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  String? _token;
  String? get token => _token;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _loading = false;
  bool get loading => _loading;

  final FlutterSecureStorage _storage =
  const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  Future<void> tryAutoLogin() async {
    _loading = true;
    notifyListeners();
    final token = await _storage.read(key: 'token');
    if (token != null) {
      _token = token;
      _isAuthenticated = true;
    }
    _loading = false;
    notifyListeners();
  }



  Future<void> logout() async {
    _isAuthenticated = false;
    _token = null;
    await _storage.deleteAll();
    notifyListeners();
  }
}


/// This widget manages the app start to handle auto-login, splash, and biometric auth on resume
class AuthHandler extends StatefulWidget {
  const AuthHandler({Key? key}) : super(key: key);
  @override
  State<AuthHandler> createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> with WidgetsBindingObserver {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _locked = false;
  Timer? _lockTimer;
  static const _timeout = Duration(minutes: 1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initAuth();
  }

  Future<void> _initAuth() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    await ap.tryAutoLogin();
    if (ap.isAuthenticated) _resetLock();
    setState(() {});
  }

  void _resetLock() {
    _lockTimer?.cancel();
    _locked = false;
    _lockTimer = Timer(_timeout, () {
      setState(() => _locked = true);
    });
  }

  Future<void> _authenticate() async {
    final canAuth = await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    bool ok = false;
    if (canAuth) {
      ok = await _auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(biometricOnly: true, stickyAuth: true),
      );
    }
    if (!ok) {
      await _showFailureDialog();
    } else {
      _resetLock();
    }
  }

  Future<void> _showFailureDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Authentication Failed'),
        content: const Text('Cannot access the app. Exiting now.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              SystemNavigator.pop();
            },
            child: const Text('Exit'),
          )
        ],
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    if (state == AppLifecycleState.paused) {
      _lockTimer?.cancel();
    } else if (state == AppLifecycleState.resumed && ap.isAuthenticated) {
      if (_locked) _authenticate();
      else _resetLock();
    }
  }

  @override
  void dispose() {
    _lockTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final ap = Provider.of<AuthProvider>(ctx);
    if (ap.loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (!ap.isAuthenticated) return const SplashPage();
    if (_locked) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _authenticate,
            child: const Text('Unlock App'),
          ),
        ),
      );
    }
    return const HomePage();
  }
}
