




import 'package:cura_kefi/Provider/Appointment_Provider.dart';
import 'package:cura_kefi/Provider/Booking_Provider.dart';
import 'package:cura_kefi/Provider/Home_Provider.dart';
import 'package:cura_kefi/Provider/Login_Provider.dart';
import 'package:cura_kefi/Provider/Offline_Provider.dart';
import 'package:cura_kefi/Provider/Online_Provider.dart';
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
        ChangeNotifierProvider(create: (_) => LoginProvider()),
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















// import 'package:cura_kefi/Provider/Appointment_Provider.dart';
// import 'package:cura_kefi/Provider/Booking_Provider.dart';
// import 'package:cura_kefi/Provider/Offline_Provider.dart';
// import 'package:cura_kefi/Provider/Online_Provider.dart';
// import 'package:cura_kefi/Provider/ReBooking_Provider.dart';
// import 'package:cura_kefi/Provider/Home_Provider.dart';
// import 'package:cura_kefi/Provider/Login_Provider.dart';
// import 'package:cura_kefi/Provider/Profile_Provider.dart';
// import 'package:cura_kefi/Provider/Splash_Provider.dart';
// import 'package:cura_kefi/Provider/SwitchUser_Provider.dart';
// import 'package:cura_kefi/Views/Home.dart';
// import 'package:cura_kefi/Views/Login.dart';
// import 'package:cura_kefi/Views/Splash.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:clarity_flutter/clarity_flutter.dart';
//
// void main() {
//   // final config = ClarityConfig(
//   //     projectId: "your_project_id" // You can find it on the Settings page of Clarity dashboard.
//   // );
//   runApp(
//       // ClarityWidget(
//     // app:
//     MyApp(),
//     // clarityConfig: config,
//   // )
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//     ChangeNotifierProvider(create: (_) => SplashProvider()),
//     ChangeNotifierProvider(create: (_) => LoginProvider()),
//     ChangeNotifierProvider(create: (_) => HomeProvider()),
//     ChangeNotifierProvider(create: (_) => ProfileProvider()),
//     ChangeNotifierProvider(create: (_) => BookingProvider()),
//     ChangeNotifierProvider(create: (_) => AppointmentProvider()),
//     ChangeNotifierProvider(create: (_) => RebookingProvider()),
//     ChangeNotifierProvider(create: (_) => UserProvider()),
//     ChangeNotifierProvider(create: (_) => OnlineProvider()),
//     ChangeNotifierProvider(create: (_) => OfflineProvider()),
//     ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'KefiCura',
//         theme: ThemeData(primarySwatch: Colors.blue),
//         initialRoute: '/',
//         routes: {
//           '/': (ctx) => SplashPage(),
//           '/login': (ctx) => LoginPage(),
//           '/home': (ctx) => HomePage(),
//         },
//       ),
//     );
//   }
// }
//       // MultiProvider(
//       // providers: [
//       //   ChangeNotifierProvider(create: (_) => SplashProvider()),
//       //   ChangeNotifierProvider(create: (_) => LoginProvider()),
//       //   ChangeNotifierProvider(create: (_) => HomeProvider()),
//       //   ChangeNotifierProvider(create: (_) => ProfileProvider()),
//       //   ChangeNotifierProvider(create: (_) => BookingProvider()),
//       //   ChangeNotifierProvider(create: (_) => AppointmentProvider()),
//       //   ChangeNotifierProvider(create: (_) => RebookingProvider()),
//       //   ChangeNotifierProvider(create: (_) => UserProvider()),
//       //   ChangeNotifierProvider(create: (_) => OnlineProvider()),
//       //   ChangeNotifierProvider(create: (_) => OfflineProvider()),
//       // ],
//       // child:
// //       MaterialApp(
// //         debugShowCheckedModeBanner: false,
// //         title: 'KefiCura',
// //         theme: ThemeData(primarySwatch: Colors.blue),
// //         initialRoute: '/',          // Set the starting page
// //         routes: {
// //           '/': (context) => SplashPage(),
// //           '/login': (context) => LoginPage(),
// //           '/home': (context) => HomePage(),
// //         },
// //       );
// //   }
// // }