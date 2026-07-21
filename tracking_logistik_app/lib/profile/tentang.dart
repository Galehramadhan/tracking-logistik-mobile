import 'package:flutter/material.dart';

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tentang Aplikasi"),
        backgroundColor: const Color(0xff0A57D7),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                Icons.local_shipping,
                size: 80,
                color: Colors.blue,
              ),

              SizedBox(height: 20),

              Text(
                "Driver Delivery App",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "Versi 1.0.0",
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),

              Text(
                "Aplikasi ini digunakan untuk membantu driver dalam menerima tugas pengiriman, melihat riwayat, serta mengelola informasi akun.",
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
      ),
    );
  }
}