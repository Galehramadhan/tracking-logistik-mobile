import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracking_logistik_app/BelakangLayar/loginscreen.dart';
import 'package:tracking_logistik_app/Pengiriman/pengiriman_main.dart';
import 'BelakangLayar/controller.dart';

// FIX 1: Pastikan kamu meng-import file tempat MainDashboard berada
import 'package:tracking_logistik_app/Dashboard/mainberanda.dart'; 

void main() {
  // Kalau pakai SharedPreferencesAsync, sangat disarankan menambahkan baris ini
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SafeShipApp()));
}

class SafeShipApp extends StatefulWidget {
  const SafeShipApp({super.key});

  @override
  State<SafeShipApp> createState() => _SafeShipAppState();
}

class _SafeShipAppState extends State<SafeShipApp> {
  // 1. Buat "toples" atau controllernya di sini
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeShip App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1964D4), // Biru Utama
          primary: const Color(0xFF1964D4),
          background: const Color(0xFFF8F9FB),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xFF1964D4),
          primary: const Color(0xFF4A89F3),
        ),
      ),
      themeMode: ThemeMode.system, 
      
      // ========================================================
      // FIX 2: Hapus `home:` dan gunakan sistem Routing Peta
      // ========================================================
      initialRoute: '/login', // Tentukan titik mulai aplikasi
      
      routes: {
        // Daftarkan alamat '/login'
        '/login': (context) => LoginScreen(authController: _authController),
        
        // Daftarkan alamat '/' agar Navigator.pushReplacementNamed tahu tujuannya
        '/dashboard': (context) => const MainDashboard(),
        '/pengiriman':(context) => const ShipmentPage(),

      },
    );
  }
}