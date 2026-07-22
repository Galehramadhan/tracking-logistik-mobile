import 'package:flutter/material.dart';

class DriverDetailPage extends StatelessWidget {
  const DriverDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi Admin"),
        backgroundColor: const Color(0xff0A57D7),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          detailItem("Nama", "Budi Santoso"),
          detailItem("ID Admin", "DRV00125"),
          detailItem("No HP", "081234567890"),
          detailItem("Email", "budi@email.com"),
          detailItem("Jenis Kelamin", "Laki-laki"),
          detailItem("Tanggal Lahir", "12 Januari 1998"),
          detailItem("Alamat", "Jl. Kol. M. Kukuh No.12, Jambi"),
          detailItem("Status", "Aktif"),

        ],
      ),
    );
  }

  Widget detailItem(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}