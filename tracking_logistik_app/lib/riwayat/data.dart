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
  void ubahStatus(String id, String statusBaru) {
    state = [
      for (final shipment in state)
        if (shipment.id == id)
          ShipmentEntity(
            id: shipment.id,
            resi: shipment.resi,
            status: statusBaru, // Update statusnya
            date: shipment.date,
            origin: shipment.origin,
            destination: shipment.destination,
          )
        else
          shipment, // Biarkan yang lain tetap sama
    ];
  }
}

// 2. Ganti Provider biasa menjadi StateNotifierProvider
final shipmentListProvider = StateNotifierProvider<ShipmentNotifier, List<ShipmentEntity>>((ref) {
  return ShipmentNotifier([
    ShipmentEntity(id: '1', resi: 'TRK-2405-0001', status: 'Selesai', date: DateTime(2026, 5, 24, 10, 30), origin: 'Jakarta', destination: 'Surabaya'),
    ShipmentEntity(id: '2', resi: 'TRK-2405-0002', status: 'Batal', date: DateTime(2026, 5, 23, 14, 20), origin: 'Bandung', destination: 'Semarang'),
    ShipmentEntity(id: '3', resi: 'TRK-2405-0003', status: 'Selesai', date: DateTime(2026, 5, 22, 9, 15), origin: 'Jakarta', destination: 'Yogyakarta'),
    ShipmentEntity(id: '4', resi: 'TRK-2405-0004', status: 'Batal', date: DateTime(2026, 5, 21, 16, 45), origin: 'Medan', destination: 'Palembang'),
    ShipmentEntity(id: '5', resi: 'TRK-2405-0005', status: 'Selesai', date: DateTime(2026, 5, 20, 8, 0), origin: 'Surabaya', destination: 'Bali'),
    ShipmentEntity(id: '6', resi: 'TRK-2405-0006', status: 'Batal', date: DateTime(2026, 5, 19, 11, 10), origin: 'Makassar', destination: 'Manado'),
    ShipmentEntity(id: '7', resi: 'TRK-2405-0007', status: 'Selesai', date: DateTime(2026, 5, 18, 13, 25), origin: 'Balikpapan', destination: 'Samarinda'),
    ShipmentEntity(id: '8', resi: 'TRK-2405-0008', status: 'Selesai', date: DateTime(2026, 5, 17, 15, 50), origin: 'Jakarta', destination: 'Lampung'),
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