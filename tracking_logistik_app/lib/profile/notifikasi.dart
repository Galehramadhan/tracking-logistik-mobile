import 'package:flutter/material.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan Notifikasi"),
        backgroundColor: const Color(0xff0A57D7),
      ),
      body: ListView(
        children: const [

          SwitchListTile(
            value: true,
            onChanged: null,
            title: Text("Notifikasi Pengiriman"),
          ),

          SwitchListTile(
            value: true,
            onChanged: null,
            title: Text("Notifikasi Pendapatan"),
          ),

          SwitchListTile(
            value: false,
            onChanged: null,
            title: Text("Mode Senyap"),
          ),

        ],
      ),
    );
  }
}