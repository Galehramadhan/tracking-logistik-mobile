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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              height: 85,
              color: colorScheme.primary,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Detail Pengiriman",
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

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _infoCard(
                    context,
                    "Nomor Resi",
                    trackingNumber,
                    Icons.receipt_long,
                  ),
                  _infoCard(
                    context,
                    "Pengirim",
                    sender,
                    Icons.person_outline,
                  ),
                  _infoCard(
                    context,
                    "Penerima",
                    receiver,
                    Icons.person,
                  ),
                  _infoCard(
                    context,
                    "Alamat Tujuan",
                    address,
                    Icons.location_on_outlined,
                  ),
                  _infoCard(
                    context,
                    "Berat Paket",
                    weight,
                    Icons.inventory_2_outlined,
                  ),

                  const SizedBox(height: 15),

                  Container(
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
                        Text(
                          "Status Pengiriman",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        _statusItem(
                          context,
                          "Pesanan dibuat",
                          "08.00 WIB",
                          true,
                        ),

                        _statusItem(
                          context,
                          "Paket diambil driver",
                          "08.15 WIB",
                          true,
                        ),

                        _statusItem(
                          context,
                          "Dalam perjalanan",
                          "08.30 WIB",
                          true,
                        ),

                        _statusItem(
                          context,
                          "Paket diterima",
                          "Menunggu",
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

  Widget _infoCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusItem(
    BuildContext context,
    String title,
    String time,
    bool active,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Icon(
            active
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: active ? Colors.green : Colors.grey,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight:
                    active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),

          Text(
            time,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}