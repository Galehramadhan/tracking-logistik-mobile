import 'package:flutter/material.dart';

class ShipmentDetailPage extends StatelessWidget {
  final String trackingNumber;
  final String sender;
  final String receiver;
  final String address;
  final String weight;

  const ShipmentDetailPage({
    super.key,
    required this.trackingNumber,
    required this.sender,
    required this.receiver,
    required this.address,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 0, 0, 0),

      body: SafeArea(
        child: Column(
          children: [

            // HEADER
            Container(
              height: 85,
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
                        'Detail Pengiriman',
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

            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.all(16),
                children: [

                  _infoCard(
                    title: 'Nomor Resi',
                    value: trackingNumber,
                    icon: Icons.receipt_long,
                  ),

                  _infoCard(
                    title: 'Pengirim',
                    value: sender,
                    icon: Icons.person_outline,
                  ),

                  _infoCard(
                    title: 'Penerima',
                    value: receiver,
                    icon: Icons.person,
                  ),

                  _infoCard(
                    title: 'Alamat Tujuan',
                    value: address,
                    icon: Icons.location_on_outlined,
                  ),

                  _infoCard(
                    title: 'Berat Paket',
                    value: weight,
                    icon: Icons.inventory_2_outlined,
                  ),

                  const SizedBox(height: 15),

                  Container(
                    padding:
                        const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 36, 31, 31),
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        const Text(
                          'Status Pengiriman',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 20),

                        _statusItem(
                          'Pesanan dibuat',
                          '08.00 WIB',
                          true,
                        ),

                        _statusItem(
                          'Paket diambil driver',
                          '08.15 WIB',
                          true,
                        ),

                        _statusItem(
                          'Dalam perjalanan',
                          '08.30 WIB',
                          true,
                        ),

                        _statusItem(
                          'Paket diterima',
                          'Menunggu',
                          false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 32, 28, 28),
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xffE5E7EB),
        ),
      ),
      child: Row(
        children: [

          Icon(
            icon,
            color: const Color(0xff0755C9),
          ),

          const SizedBox(width: 14),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusItem(
    String title,
    String time,
    bool active,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [

          Icon(
            active
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: active
                ? Colors.green
                : Colors.grey,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: active
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),

          Text(
            time,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}