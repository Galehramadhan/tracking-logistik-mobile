import 'package:flutter/material.dart';
import 'trackingg.dart';
import 'trakingmaps.dart';

class ShipmentPage extends StatefulWidget {
  const ShipmentPage({super.key});

  @override
  State<ShipmentPage> createState() => _ShipmentPageState();
}

class _ShipmentPageState extends State<ShipmentPage> {
  String selectedStatus = 'Ditugaskan';

  final List<Map<String, String>> shipments = [
    {
      'trackingNumber': 'TRK-2405-0001',
      'status': 'Sedang Diantar',
      'sender': 'Gudang Jambi',
      'receiver': 'Universitas Jambi',
      'address': 'Jl. Raya Jambi',
      'weight': '3 Kg',
      'estimate': '09.30 WIB',
    },
    {
      'trackingNumber': 'TRK-2405-0002',
      'status': 'Ditugaskan',
      'sender': 'PT ABC',
      'receiver': 'Budi Santoso',
      'address': 'Jl. Kol M. Kukuh No. 12',
      'weight': '5 Kg',
      'estimate': '10.15 WIB',
    },
    {
      'trackingNumber': 'TRK-2405-0003',
      'status': 'Ditugaskan',
      'sender': 'Toko Sumber Rezeki',
      'receiver': 'Siti Aisyah',
      'address': 'Jl. Hayam Wuruk No. 45',
      'weight': '2 Kg',
      'estimate': '11.00 WIB',
    },
    {
      'trackingNumber': 'TRK-2405-0004',
      'status': 'Selesai',
      'sender': 'CV Makmur Jaya',
      'receiver': 'Andi Pratama',
      'address': 'Jl. Lingkar Selatan',
      'weight': '4 Kg',
      'estimate': '08.15 WIB',
    },
  ];

  final List<String> statusList = [
    'Ditugaskan',
    'Sedang Diantar',
    'Selesai',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final filteredShipments = shipments
        .where((shipment) => shipment['status'] == selectedStatus)
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
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: Row(
                children: statusList.map((status) {
                  final isSelected = selectedStatus == status;

                  return Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStatus = status;
                          });
                        },
                        child: AnimatedContainer(
                          duration:
                              const Duration(milliseconds: 200),
                          padding:
                              const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colorScheme.primary
                                : theme.cardColor,
                            borderRadius:
                                BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? colorScheme.primary
                                  : theme.dividerColor,
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
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
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
                        final shipment =
                            filteredShipments[index];

                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: 14),
                          child: _shipmentCard(
                            context: context,
                            trackingNumber:
                                shipment["trackingNumber"]!,
                            status: shipment["status"]!,
                            sender: shipment["sender"]!,
                            receiver: shipment["receiver"]!,
                            address: shipment["address"]!,
                            weight: shipment["weight"]!,
                            estimate: shipment["estimate"]!,
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
        // RESI & STATUS
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
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
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
                            builder: (_) =>
                                const MapTrackingPage(),
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
                      onPressed: status == "Ditugaskan"
                          ? () {
                              setState(() {
                                final index =
                                    shipments.indexWhere(
                                  (shipment) =>
                                      shipment[
                                          "trackingNumber"] ==
                                      trackingNumber,
                                );

                                if (index != -1) {
                                  shipments[index]["status"] =
                                      "Sedang Diantar";
                                }

                                selectedStatus =
                                    "Sedang Diantar";
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            colorScheme.primary,
                        foregroundColor:
                            colorScheme.onPrimary,
                      ),
                      child: Text(
                        status == "Ditugaskan"
                            ? "Ambil Barang"
                            : "Selesai",
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