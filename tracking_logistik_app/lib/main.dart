import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard/beranda.dart';
import 'package:tracking_logistik_app/riwayat/riwayatpengiriman.dart';

void main() {
  runApp(const SafeShipApp());

    runApp(
    const ProviderScope(
      child: SafeShipApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HistoryPage(),
    );
  }
}