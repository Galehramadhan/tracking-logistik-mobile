class ShipmentEntity {
  final String id;
  final String resi;
  final String status; // 'Selesai' atau 'Batal'
  final DateTime date;
  final String origin;
  final String destination;

  ShipmentEntity({
    required this.id,
    required this.resi,
    required this.status,
    required this.date,
    required this.origin,
    required this.destination,
  });
}