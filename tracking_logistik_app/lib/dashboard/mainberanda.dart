import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'beranda.dart'; // Ini sudah benar, memanggil HomeView dan class Dummy dari beranda.dart
import 'package:tracking_logistik_app/Pengiriman/pengiriman_main.dart';
import 'package:tracking_logistik_app/Riwayat/riwayatpengiriman.dart';
import 'package:tracking_logistik_app/profile/profilemain.dart';
class MainDashboard extends ConsumerStatefulWidget {
  const MainDashboard({super.key});

  @override
  ConsumerState<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends ConsumerState<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeView(), 
    const ShipmentPage(), 
    const HistoryPage(),
    const ProfilePage(), 
  ];

  @override
  Widget build(BuildContext context) {
    // Panggil tema global
    final tema = Theme.of(context);
    final cardColor = tema.brightness == Brightness.dark ? const Color(0xFF2C2C2E) : Colors.white;

    return Scaffold(
      body: _pages[_currentIndex], // Layar berganti otomatis mengikuti index
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: cardColor,
        // FIX 1: Gunakan warna primary dari tema
        selectedItemColor: tema.colorScheme.primary, 
        unselectedItemColor: const Color(0xFF8E8E93),
        selectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
        elevation: 16,
        
        // FIX 2: Tambahkan ini agar tombol di bawah ikut menyala
        currentIndex: _currentIndex, 
        
        onTap: (index) {
          // FIX 3: Cukup ubah state (ganti channel), JANGAN gunakan Navigator.push!
          setState(() {
            _currentIndex = index; 
          });
          
          if (index == 2) {
             // ref.read(statusFilterProvider.notifier).state = 'Semua';
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Pengiriman'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}