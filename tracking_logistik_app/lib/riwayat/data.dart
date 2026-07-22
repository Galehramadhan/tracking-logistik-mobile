import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shipment_entity.dart';

// State untuk filter status
final statusFilterProvider = StateProvider<String>((ref) => 'Semua');

// State untuk pencarian nomor resi
final searchProvider = StateProvider<String>((ref) => '');

// State untuk filter tanggal
final dateFilterProvider = StateProvider<DateTime?>((ref) => null);

// 1. Buat Notifier untuk mengatur logika penambahan data
class ShipmentNotifier extends StateNotifier<List<ShipmentEntity>> {
  ShipmentNotifier(super.state);

  // Fungsi untuk menambah data hasil scan ke dalam list
  void tambahPengiriman(ShipmentEntity dataBaru) {
    state = [...state, dataBaru]; // Menambahkan objek baru ke daftar state
  }
}

// 2. Ganti Provider biasa menjadi StateNotifierProvider
final shipmentListProvider = StateNotifierProvider<ShipmentNotifier, List<ShipmentEntity>>((ref) {
  return ShipmentNotifier([
    // Kamu bisa biarkan data dummy lamamu di sini sebagai nilai awal
    ShipmentEntity(id: '1', resi: 'TRK-2405-0001', status: 'Selesai', date: DateTime(2024, 5, 24, 10, 30), origin: 'Jakarta', destination: 'Surabaya'),
  ]);
});

// Provider untuk List yang sudah di-filter
final filteredShipmentsProvider = Provider<List<ShipmentEntity>>((ref) {
  final shipments = ref.watch(shipmentListProvider);
  final statusFilter = ref.watch(statusFilterProvider);
  final searchQuery = ref.watch(searchProvider).toLowerCase();
  final dateFilter = ref.watch(dateFilterProvider);

  return shipments.where((shipment) {
    // 1. Filter Status
    final matchStatus = statusFilter == 'Semua' || shipment.status == statusFilter;
    
    // 2. Filter Search (No. Resi)
    final matchSearch = shipment.resi.toLowerCase().contains(searchQuery);
    
    // 3. Filter Date
    bool matchDate = true;
    if (dateFilter != null) {
      matchDate = shipment.date.year == dateFilter.year &&
                  shipment.date.month == dateFilter.month &&
                  shipment.date.day == dateFilter.day;
    }

    return matchStatus && matchSearch && matchDate;
  }).toList();
});