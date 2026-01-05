import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_guest_page.dart';
import 'pages/edit_booking_page.dart';

void main() {
  runApp(const HallBookingApp());
}

class HallBookingApp extends StatelessWidget {
  const HallBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ✅ START DARI LOGIN
      home: const LoginPage(),

      // ✅ ROUTES (EDIT BOOKING GUNA NAMA)
      routes: {
        '/home': (context) => const HomeGuestPage(),
        '/editBooking': (context) => const EditBookingPage(),
      },

      // ✅ GLOBAL THEME (HITAM + GOLD)
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7EDE9),

        primaryColor: Colors.black,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Color(0xFFD4AF37),
          centerTitle: true,
          elevation: 0,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Color(0xFFD4AF37),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFD4AF37),
            side: const BorderSide(color: Color(0xFFD4AF37)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          ),
        ),

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
          secondary: const Color(0xFFD4AF37),
        ),
      ),
    );
  }
}
