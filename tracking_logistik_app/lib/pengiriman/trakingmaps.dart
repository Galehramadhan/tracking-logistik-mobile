import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapTrackingPage extends StatefulWidget {
  const MapTrackingPage({super.key});

  @override
  State<MapTrackingPage> createState() => _MapTrackingPageState();
}

class _MapTrackingPageState extends State<MapTrackingPage> {
  GoogleMapController? mapController;

  // Koordinat awal (default menggunakan titik di Jambi sebagai fallback)
  LatLng driverLocation = const LatLng(-1.6101, 103.6131);
  final LatLng destinationLocation = const LatLng(-1.6099, 103.6065);

  @override
  void initState() {
    super.initState();
    _initLocationTracking(); // Jalankan pelacakan GPS saat halaman dibuka
  }

  // Fungsi untuk meminta izin dan memantau posisi GPS secara real-time
  Future<void> _initLocationTracking() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Cek apakah layanan GPS aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    // 2. Cek izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    // 3. Ambil posisi awal saat pertama kali dibuka
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      driverLocation = LatLng(position.latitude, position.longitude);
    });

    // 4. Pantau perubahan posisi kurir secara terus-menerus (Live Tracking)
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update posisi setiap kurir bergerak sejauh 10 meter
      ),
    ).listen((Position position) {
      setState(() {
        driverLocation = LatLng(position.latitude, position.longitude);
      });

      // Geser kamera peta secara otomatis mengikuti pergerakan kurir
      mapController?.animateCamera(
        CameraUpdate.newLatLng(driverLocation),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Marker posisi kurir dan tujuan secara dinamis
    final Set<Marker> markers = {
      Marker(
        markerId: const MarkerId("driver"),
        position: driverLocation,
        infoWindow: const InfoWindow(
          title: "Posisi Kurir",
          snippet: "Sedang dalam perjalanan",
        ),
      ),
      Marker(
        markerId: const MarkerId("destination"),
        position: destinationLocation,
        infoWindow: const InfoWindow(
          title: "Tujuan Pengiriman",
          snippet: "Universitas Jambi",
        ),
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lacak Lokasi"),
      ),
      body: Column(
        children: [
          // PETA GOOGLE MAPS LIVE LOCATION
          Expanded(
            flex: 3,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: driverLocation,
                zoom: 15,
              ),
              markers: markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
          ),

          // INFORMASI STATUS PENGIRIMAN
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Status Pengiriman",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.local_shipping,
                      color: Colors.green,
                    ),
                    title: Text("Kurir sedang menuju alamat tujuan"),
                    subtitle: Text("Estimasi tiba 15 menit lagi"),
                  ),
                  const Divider(),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
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