import 'package:flutter/material.dart';

// ================= DATABASE =================
import 'data/database_helper.dart';

// ================= USER PAGES =================
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_guest_page.dart';
import 'pages/hall_list_page.dart';
import 'pages/date_time_page.dart';
import 'pages/summary_page.dart';
import 'pages/my_bookings_page.dart';

// ================= ADMIN PAGES =================
import 'pages/admin_login_page.dart';
import 'pages/admin_dashboard_page.dart';
import 'pages/manage_halls_page.dart';
import 'pages/admin_manage_bookings_page.dart';
import 'pages/manage_users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Hall Booking',

      // ================= GLOBAL THEME =================
      theme: ThemeData(
        useMaterial3: true,

        // 🌸 BACKGROUND (SEMUA PAGE)
        scaffoldBackgroundColor: const Color(0xFFFDF7F4),

        // 🌸 COLOR SCHEME
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC9A24D), // GOLD
          primary: const Color(0xFFC9A24D),
          secondary: const Color(0xFFE8CFCB), // SOFT PINK
        ),

        // 🌸 APP BAR (SEMUA PAGE)
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFDF7F4),
          elevation: 0,
          centerTitle: true,
          foregroundColor: Color(0xFF1F1F1F),
          titleTextStyle: TextStyle(
            color: Color(0xFF1F1F1F),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // 🌸 CARD (FRAME EFFECT)
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(
              color: Color(0xFFE6C9A8), // GOLD BORDER
              width: 1,
            ),
          ),
        ),

        // 🌸 BUTTON (DEFAULT – STILL OVERRIDABLE)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2C2C2C),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 26,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
          ),
        ),

        // 🌸 TEXT
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F1F1F),
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F1F1F),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF3A3A3A),
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Color(0xFF7A7A7A),
          ),
        ),

        // 🌸 INPUT (LOGIN / REGISTER / ADMIN)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE6C9A8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE6C9A8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFC9A24D),
              width: 1.4,
            ),
          ),
          labelStyle: const TextStyle(color: Color(0xFF7A7A7A)),
        ),

        // 🌸 CATEGORY CHIPS
        chipTheme: ChipThemeData(
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFFC9A24D),
          labelStyle: const TextStyle(color: Color(0xFF1F1F1F)),
          secondaryLabelStyle: const TextStyle(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),

      // ================= START =================
      home: LoginPage(),

      // ================= ROUTES =================
      routes: {
        // -------- USER --------
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/homeGuest': (context) => const HomeGuestPage(),
        '/hallList': (context) => const HallListPage(),
        '/dateTime': (context) => const DateTimePage(),
        '/summary': (context) => const SummaryPage(),
        '/myBookings': (context) => const MyBookingsPage(),

        // -------- ADMIN --------
        '/adminLogin': (context) => AdminLoginPage(),
        '/adminDashboard': (context) => const AdminDashboardPage(),
        '/manageHalls': (context) => const ManageHallsPage(),
        '/adminManageBookings': (context) =>
            const AdminManageBookingsPage(),
        '/manageUsers': (context) => const ManageUsersPage(),
      },
    );
  }
}
