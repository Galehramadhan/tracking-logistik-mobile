import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Wajib import ini
import 'package:tracking_logistik_app/riwayat/data.dart'; // Import data Riverpod-mu
import 'trackingg.dart';
import 'trakingmaps.dart';

// 1. Ubah jadi ConsumerStatefulWidget
class ShipmentPage extends ConsumerStatefulWidget {
  const ShipmentPage({super.key});

  @override
  ConsumerState<ShipmentPage> createState() => _ShipmentPageState();
}

class _ShipmentPageState extends ConsumerState<ShipmentPage> {
  String selectedStatus = 'Ditugaskan';

  final List<String> statusList = [
    'Ditugaskan',
    'Sedang Diantar',
    'Selesai',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 2. Trik Ajaib: Ambil data langsung dari Riverpod!
    final allShipments = ref.watch(shipmentListProvider);

    // 3. Filter data berdasarkan tab yang sedang aktif
    final filteredShipments = allShipments
        .where((shipment) => shipment.status == selectedStatus)
        .toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 95,
              color: colorScheme.primary,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "Tugas Pengiriman",
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Row(
                children: statusList.map((status) {
                  final isSelected = selectedStatus == status;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStatus = status;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? colorScheme.primary : theme.cardColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? colorScheme.primary : theme.dividerColor,
                            ),
                          ),
                          child: Text(
                            status,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected
                                  ? colorScheme.onPrimary
                                  : theme.textTheme.bodyMedium?.color,
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: filteredShipments.isEmpty
                  ? Center(
                      child: Text(
                        "Belum ada pengiriman",
                        style: theme.textTheme.bodyMedium,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredShipments.length,
                      itemBuilder: (context, index) {
                        final shipment = filteredShipments[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _shipmentCard(
                            context: context,
                            id: shipment.id, // Parsing ID
                            trackingNumber: shipment.resi,
                            status: shipment.status,
                            sender: shipment.origin,
                            receiver: shipment.destination,
                            // Dummy sementara untuk data yg belum ada di QR
                            address: 'Alamat tujuan di: ${shipment.destination}', 
                            weight: '1 Kg',
                            estimate: 'Hari ini',
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // CARD PENGIRIMAN
  // =====================================================

  Widget _shipmentCard({
    required BuildContext context,
    required String id, // Tambahan parameter ID
    required String trackingNumber,
    required String status,
    required String sender,
    required String receiver,
    required String address,
    required String weight,
    required String estimate,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                trackingNumber,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: status == "Selesai"
                      ? Colors.green.withOpacity(0.15)
                      : status == "Sedang Diantar"
                          ? colorScheme.primary.withOpacity(0.15)
                          : Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: status == "Selesai"
                        ? Colors.green
                        : status == "Sedang Diantar"
                            ? colorScheme.primary
                            : Colors.orange,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            "Pengirim",
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
          ),
          Text(
            sender,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Penerima",
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
          ),
          Text(
            receiver,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Alamat",
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
          ),
          Text(address),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "📦 $weight",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "⏱ $estimate",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    side: BorderSide(
                      color: colorScheme.primary,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TrackingPage(
                          trackingNumber: trackingNumber,
                          sender: sender,
                          receiver: receiver,
                          address: address,
                          weight: weight,
                        ),
                      ),
                    );
                  },
                  child: const Text("Lihat Detail"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: status == "Sedang Diantar"
                    ? ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MapTrackingPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.location_on,
                          size: 18,
                        ),
                        label: const Text("Lacak Lokasi"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      )
                    : ElevatedButton(
                        // 4. Update status menggunakan Riverpod!
                        onPressed: status == "Ditugaskan"
                            ? () {
                                ref
                                    .read(shipmentListProvider.notifier)
                                    .ubahStatus(id, "Sedang Diantar");
                                
                                setState(() {
                                  selectedStatus = "Sedang Diantar"; // Pindah tab otomatis
                                });
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                        ),
                        child: Text(
                          status == "Ditugaskan" ? "Ambil Barang" : "Selesai",
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}