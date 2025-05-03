import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'package:app/providers/phone_number_provider.dart' as phone_provider;

// Screens
import 'package:app/splash.dart';
import 'package:app/welcome.dart';
import 'package:app/getotp.dart';
import 'package:app/confirmotp.dart';
import 'package:app/home_page.dart';
import 'package:app/lines.dart';
import 'package:app/schedule.dart';
import 'package:app/feedback.dart';
import 'package:app/settings.dart';
import 'package:app/profile.dart';
import 'package:app/createaccount.dart';
import 'package:app/aboutus.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => phone_provider.PhoneNumberProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transport App',
      initialRoute: '/splash',
      theme: ThemeData(
        primaryColor: const Color(0xFF0A1744),
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomePage(),
        '/getotp': (context) => const OtpScreen(),
        '/confirmotp': (context) => const Confirmotp(),
        '/createaccount': (context) => const CreateAccountScreen(),
        '/home': (context) => const HomePage(),
        '/lines': (context) => const Lines(),
        '/schedule': (context) => const SchedulePage(),
        '/feedback': (context) => const FeedbackScreen(),
        '/settings': (context) => const Settings(),
        '/editprofile': (context) => const Profile(),
        '/aboutus': (context) => const AboutScreen(),
      },
    );
  }
}
