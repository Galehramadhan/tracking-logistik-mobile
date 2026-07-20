import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data.dart';
// import 'shipment_detail_page.dart'; // Akan digunakan untuk navigasi ke detail

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredData = ref.watch(filteredShipmentsProvider);
    final currentStatus = ref.watch(statusFilterProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          'Riwayat Pengiriman',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF1976D2), // Biru utama profesional
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchAndDateSection(context, ref),
          _buildFilterSection(context, ref, currentStatus),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final shipment = filteredData[index];
                return _buildHistoryCard(context, shipment);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndDateSection(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) => ref.read(searchProvider.notifier).state = value,
              decoration: InputDecoration(
                hintText: 'Cari berdasarkan No. Resi',
                hintStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Color(0xFF1976D2), // Biru utama
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (selectedDate != null) {
                ref.read(dateFilterProvider.notifier).state = selectedDate;
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.calendar_month, color: Color(0xFF1976D2)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, WidgetRef ref, String currentStatus) {
    final filters = ['Semua', 'Selesai', 'Tertunda'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: filters.map((filter) {
          final isSelected = currentStatus == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(
                filter,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              selectedColor: const Color(0xFF1976D2),
              backgroundColor: Theme.of(context).colorScheme.surface,
              onSelected: (selected) {
                if (selected) {
                  ref.read(statusFilterProvider.notifier).state = filter;
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, shipment) {
    final isSelesai = shipment.status == 'Selesai';

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: Implementasi navigasi ke halaman Detail
            // Navigator.push(context, MaterialPageRoute(builder: (_) => ShipmentDetailPage(shipment: shipment)));
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      shipment.resi,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelesai ? Colors.green.shade50 : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        shipment.status,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: isSelesai ? Colors.green.shade700 : Colors.red.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "${shipment.date.day}/${shipment.date.month}/${shipment.date.year} • ${shipment.date.hour}:${shipment.date.minute}",
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      shipment.origin,
                      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                    ),
                    const Icon(Icons.local_shipping_outlined, color: Color(0xFF1976D2)),
                    Text(
                      shipment.destination,
                      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Simple Progress Line Indicator
                Row(
                  children: [
                    const Icon(Icons.circle, size: 12, color: Colors.green),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isSelesai ? Colors.green : Colors.grey.shade300,
                      ),
                    ),
                    Icon(
                      isSelesai ? Icons.check_circle : Icons.circle_outlined,
                      size: 14,
                      color: isSelesai ? Colors.green : Colors.grey.shade400,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
