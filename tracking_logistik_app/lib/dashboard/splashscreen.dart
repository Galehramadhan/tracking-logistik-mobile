import 'package:flutter/material.dart';
// ============================================================================
// SPLASH SCREEN VIEW
// ============================================================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _pindahKeLogin();
  }

  // Fungsi untuk mensimulasikan loading selama 3 detik
  void _pindahKeLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    
    // Validasi agar tidak error jika widget keburu ditutup
    if (!mounted) return; 

    // Pindah ke halaman Login dan HAPUS Splash dari riwayat back (pushReplacementNamed)
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1964D4), // Biru Utama
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ikon Truk sebagai Logo Sementara
            const Icon(
              Icons.local_shipping,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            const Text(
              'SafeShip',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Distribusi Cerdas & Aman',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 48),
            // Indikator Loading
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}