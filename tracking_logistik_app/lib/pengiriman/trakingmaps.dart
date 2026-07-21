import 'package:flutter/material.dart';

class MapTrackingPage extends StatelessWidget {
  const MapTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lacak Lokasi"),
      ),
      body: Column(
        children: [

          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(
                  Icons.map,
                  size: 80,
                  color: Colors.blue,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [

                  Text(
                    "Status Pengiriman",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 10),

                  ListTile(
                    leading: Icon(
                      Icons.local_shipping,
                      color: Colors.green,
                    ),
                    title: Text("Kurir sedang menuju alamat tujuan"),
                    subtitle: Text("Estimasi tiba 15 menit lagi"),
                  ),

                  Divider(),

                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text("Jl. Raya Jambi"),
                    subtitle: Text("Universitas Jambi"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}