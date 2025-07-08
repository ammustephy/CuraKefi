import 'package:cura_kefi/Provider/Appointment_Provider.dart';
import 'package:cura_kefi/Provider/AuthProvider.dart';
import 'package:cura_kefi/Provider/Booking_Provider.dart';
import 'package:cura_kefi/Provider/Home_Provider.dart';
import 'package:cura_kefi/Provider/Login_Provider.dart';
import 'package:cura_kefi/Provider/News_Provider.dart';
import 'package:cura_kefi/Provider/Profile_Provider.dart';
import 'package:cura_kefi/Provider/ReBooking_Provider.dart';
import 'package:cura_kefi/Provider/Splash_Provider.dart';
import 'package:cura_kefi/Provider/SwitchUser_Provider.dart';
import 'package:cura_kefi/Views/Home.dart';
import 'package:cura_kefi/Views/Login.dart';
import 'package:cura_kefi/Views/Splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => RebookingProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // ChangeNotifierProvider(create: (_) => OnlineProvider()),
        // ChangeNotifierProvider(create: (_) => OfflineProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KefiCura',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (ctx) => SplashPage(),
          '/login': (ctx) => LoginPage(),
          '/home': (ctx) => HomePage(),
        },
      ),
    );
  }
}












