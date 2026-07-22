import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tracking_logistik_app/riwayat/riwayatpengiriman.dart';
import 'package:tracking_logistik_app/riwayat/data.dart';
import 'package:tracking_logistik_app/Pengiriman/pengiriman_main.dart';
import 'package:tracking_logistik_app/profile/profilemain.dart';

class SafeShipApp extends StatelessWidget {
  const SafeShipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeShip',
      debugShowCheckedModeBanner: false,
      // Konfigurasi Tema Utama (Material 3 & Poppins)
      
      // Routing Dasar
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
        '/pengiriman': (context) => const ShipmentPage(),
        '/riwayat': (context) => const HistoryPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}

// ============================================================================
// PRESENTATION LAYER: HOME VIEW
// ============================================================================
class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pakai tema langsung dari bapaknya (MaterialApp)
    final tema = Theme.of(context);
    final primaryBlue = tema.colorScheme.primary;
    
    final isDarkMode = tema.brightness == Brightness.dark;
    final currentBgColor = isDarkMode ? tema.colorScheme.background : const Color(0xFFF8F9FB);
    final cardColor = isDarkMode ? const Color(0xFF2C2C2E) : Colors.white;
    final currentTextColor = isDarkMode ? Colors.white : const Color(0xFF1C1C1E);

    return Scaffold(
      backgroundColor: currentBgColor,
      // FIX 1: Hapus `bottomNavigationBar:` dari sini, karena sudah diurus MainDashboard!
      
      body: Stack(
        children: [
          // Background Biru Header
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Header: Greeting & Notifikasi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat pagi,',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Galeh Ramadhan', // Nantinya bisa di-bind dari ProfileState
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            // TODO: Implementasi navigasi ke notifikasi
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Section Scan Barcode (Menggantikan Lacak Kiriman)
                    _buildScanBarcodeCard(
                      context,
                      primaryBlue,
                      cardColor,
                      currentTextColor,
                    ),

                    const SizedBox(height: 24),

                    // Title Ringkasan Pengiriman
                    Text(
                      'Ringkasan Pengiriman',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: currentTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Grid Ringkasan Pengiriman
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: [
                        _buildSummaryCard(
                          context: context,
                          ref: ref,
                          title: 'Dalam Proses',
                          count: '2',
                          icon: Icons.inventory_2_outlined,
                          iconColor: Colors.deepPurpleAccent,
                          iconBgColor: Colors.deepPurple.withOpacity(0.1),
                          cardColor: cardColor,
                          textColor: currentTextColor,
                          targetRoute: '/pengiriman',
                          filterStatus: null,
                        ),
                        _buildSummaryCard(
                          context: context,
                          ref: ref,
                          title: 'Dalam Perjalanan',
                          count: '1',
                          icon: Icons.local_shipping_outlined,
                          iconColor: primaryBlue,
                          iconBgColor: primaryBlue.withOpacity(0.1),
                          cardColor: cardColor,
                          textColor: currentTextColor,
                          targetRoute: '/pengiriman',
                          filterStatus: null,
                        ),
                        _buildSummaryCard(
                          context: context,
                          ref: ref,
                          title: 'Selesai',
                          count: '5',
                          icon: Icons.check_circle_outline,
                          iconColor: Colors.green,
                          iconBgColor: Colors.green.withOpacity(0.1),
                          cardColor: cardColor,
                          textColor: currentTextColor,
                          targetRoute: '/riwayat',
                          filterStatus: 'Selesai',
                        ),
                        _buildSummaryCard(
                          context: context,
                          ref: ref,
                          title: 'Batal',
                          count: '3',
                          icon: Icons.schedule,
                          iconColor: Colors.orange,
                          iconBgColor: Colors.orange.withOpacity(0.1),
                          cardColor: cardColor,
                          textColor: currentTextColor,
                          targetRoute: '/riwayat',
                          filterStatus: 'Batal',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Promotional Banner (Pantau Kiriman)
                    _buildPromoBanner(primaryBlue, cardColor),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
  Widget _buildScanBarcodeCard(
    BuildContext context,
    Color primaryColor,
    Color cardColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.qr_code_scanner_rounded, color: textColor),
              const SizedBox(width: 8),
              Text(
                'Scan Barcode Driver',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Scan barcode dari perangkat driver untuk melihat detail dan mengelola pengiriman.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Color(0xFF8E8E93),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () async {
                final scannedData = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScannerView()),
                );

                // Jika berhasil mendapatkan data scan dari kamera
                if (scannedData != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Berhasil Scan Resi: $scannedData',
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  // Navigasi ke halaman pengiriman ketika discan
                  Navigator.pushNamed(context, '/pengiriman');
                }
              },
              icon: const Icon(Icons.document_scanner, color: Colors.white),
              label: const Text(
                'Scan Sekarang',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required String count,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required Color cardColor,
    required Color textColor,
    required String targetRoute,
    required String? filterStatus,
  }) {
    return GestureDetector(
      onTap: () {
        if (filterStatus != null) {
          ref.read(statusFilterProvider.notifier).state = filterStatus;
        }
        Navigator.pushNamed(context, targetRoute);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                Text(
                  count,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8E8E93),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPromoBanner(Color primaryColor, Color cardColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.map_outlined, color: primaryColor, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pantau kiriman Anda',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Dapatkan informasi terbaru status pengiriman secara real-time.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // (Letakkan fungsi _buildScanBarcodeCard, _buildSummaryCard, dan _buildPromoBanner kamu di sini)
}
// ============================================================================
// BARCODE SCANNER VIEW
// ============================================================================

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan Barcode',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController,
              builder: (context, state, child) {
                switch (state.torchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.black87);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.orange);
                  default:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                }
              },
            ),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.black87,
            icon: const Icon(Icons.flip_camera_ios),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              if (_isScanned) return;

              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String? code = barcodes.first.rawValue;
                if (code != null) {
                  setState(() {
                    _isScanned = true;
                  });

                  Navigator.pop(context, code);
                }
              }
            },
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Arahkan kamera ke barcode resi pengiriman',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  backgroundColor: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
// ============================================================================
// DUMMY VIEWS UNTUK TESTING ROUTING
// ============================================================================

class PengirimanViewDummy extends StatelessWidget {
  const PengirimanViewDummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Halaman Pengiriman',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: const Center(
        child: Text('halo')
      ),
    );
  }
}

class RiwayatViewDummy extends StatelessWidget {
  const RiwayatViewDummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Halaman Riwayat',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: const Center(
        child: Text(
          'Tampilan Riwayat Pengiriman Selesai/Batal akan di sini.',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}
