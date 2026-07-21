import 'package:flutter/material.dart';

class PendapatanPage extends StatelessWidget {
  const PendapatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pendapatan"),
        backgroundColor: const Color(0xff0A57D7),
      ),
      body: ListView(
        children: const [

          ListTile(
            leading: Icon(Icons.attach_money,color: Colors.green),
            title: Text("24 Mei 2024"),
            trailing: Text("Rp250.000"),
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.attach_money,color: Colors.green),
            title: Text("23 Mei 2024"),
            trailing: Text("Rp315.000"),
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.attach_money,color: Colors.green),
            title: Text("22 Mei 2024"),
            trailing: Text("Rp285.000"),
          ),

        ],
      ),
    );
  }
}