import 'package:flutter/material.dart';

class BantuanPage extends StatelessWidget {
  const BantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bantuan"),
        backgroundColor: const Color(0xff0A57D7),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Jika mengalami kendala saat pengiriman atau penggunaan aplikasi, silakan hubungi Admin melalui:\n\n"
          "Email : support@driver.com\n"
          "Telepon : 0812-3456-7890",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}