import 'package:flutter/material.dart';

class DokumenPage extends StatelessWidget {
  const DokumenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dokumen"),
        backgroundColor: const Color(0xff0A57D7),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.badge),
            title: Text("SIM"),
            subtitle: Text("A - Berlaku s.d 12/05/2029"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.description),
            title: Text("STNK"),
            subtitle: Text("Aktif"),
          ),
        ],
      ),
    );
  }
}