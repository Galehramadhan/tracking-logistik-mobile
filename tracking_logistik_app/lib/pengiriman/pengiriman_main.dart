import 'package:flutter/material.dart';
import 'trackingg.dart';
import 'trakingmaps.dart';

class ShipmentPage extends StatefulWidget {
  const ShipmentPage({super.key});

  @override
  State<ShipmentPage> createState() =>
      _ShipmentPageState();
}

class _ShipmentPageState
    extends State<ShipmentPage> {

  // STATUS YANG DIPILIH
  String selectedStatus = 'Ditugaskan';

  // DATA PENGIRIMAN
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

    // FILTER DATA BERDASARKAN STATUS
    final filteredShipments =
        shipments.where((shipment) {
      return shipment['status'] ==
          selectedStatus;
    }).toList();

    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 2, 4, 8),

      body: SafeArea(
        child: Column(
          children: [

            // =========================
            // HEADER
            // =========================

            Container(
              height: 95,
              color: const Color(0xff0755C9),
              child: Row(
                children: [

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        'Tugas Pengiriman',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 48),
                ],
              ),
            ),

            // =========================
            // FILTER STATUS BUTTON
            // =========================

            Container(
              color: const Color.fromARGB(255, 6, 4, 4),
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: Row(
                children: statusList.map((status) {

                  final bool isSelected =
                      selectedStatus == status;

                  return Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: GestureDetector(
                        onTap: () {

                          setState(() {
                            selectedStatus = status;
                          });

                        },
                        child: AnimatedContainer(
                          duration:
                              const Duration(
                            milliseconds: 200,
                          ),
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(
                                    0xff0755C9)
                                : Colors.white,
                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(
                                      0xff0755C9)
                                  : const Color(
                                      0xffE5E7EB),
                            ),
                          ),
                          child: Text(
                            status,
                            textAlign:
                                TextAlign.center,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey
                                      .shade700,
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

            // =========================
            // LIST PENGIRIMAN
            // =========================

            Expanded(
              child: filteredShipments.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada pengiriman',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding:
                          const EdgeInsets.all(16),
                      itemCount:
                          filteredShipments.length,
                      itemBuilder:
                          (context, index) {

                        final shipment =
                            filteredShipments[
                                index];

                        return Padding(
                          padding:
                              const EdgeInsets.only(
                            bottom: 14,
                          ),
                          child: _shipmentCard(
                            context: context,
                            trackingNumber:
                                shipment[
                                    'trackingNumber']!,
                            status:
                                shipment['status']!,
                            sender:
                                shipment['sender']!,
                            receiver:
                                shipment['receiver']!,
                            address:
                                shipment['address']!,
                            weight:
                                shipment['weight']!,
                            estimate:
                                shipment['estimate']!,
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 25, 21, 21),
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: const Color.fromARGB(255, 255, 251, 251),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          // =========================
          // NOMOR RESI & STATUS
          // =========================

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [

              Text(
                trackingNumber,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: status == 'Selesai'
                      ? const Color(0xffE8F7ED)
                      : status ==
                              'Sedang Diantar'
                          ? const Color(
                              0xffE8F1FF)
                          : const Color(
                              0xfffff4df),
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: status == 'Selesai'
                        ? Colors.green
                        : status ==
                                'Sedang Diantar'
                            ? const Color(
                                0xff0755C9)
                            : Colors.orange,
                    fontSize: 11,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Text(
            'Pengirim',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),

          Text(
            sender,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Penerima',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),

          Text(
            receiver,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Alamat',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),

          Text(address),

          const SizedBox(height: 16),

          // =========================
          // BERAT & ESTIMASI
          // =========================

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [

              Text(
                '📦 $weight',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                '⏱ $estimate',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // =========================
          // BUTTON
          // =========================

         Row(
  children: [

    Expanded(
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackingPage(
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

          // ===============================
          // BUTTON LACAK LOKASI
          // ===============================
          ? ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapTrackingPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 18,
              ),
              label: const Text(
                "Lacak Lokasi",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            )

          // ===============================
          // BUTTON AMBIL PAKET
          // ===============================
          : ElevatedButton(
              onPressed: status == "Ditugaskan"
                  ? () {
                      setState(() {
                        final index = shipments.indexWhere(
                          (shipment) =>
                              shipment["trackingNumber"] ==
                              trackingNumber,
                        );

                        if (index != -1) {
                          shipments[index]["status"] =
                              "Sedang Diantar";
                        }

                        selectedStatus = "Sedang Diantar";
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0755C9),
              ),
              child: Text(
                status == "Ditugaskan"
                    ? "Ambil Paket"
                    : "Selesai",
                style: const TextStyle(color: Colors.white),
              ),
            ),
    ),
  ],
)
        ],
      ),
    );
  }

}