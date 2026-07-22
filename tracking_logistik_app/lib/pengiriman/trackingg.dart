import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail_pengiriman.dart';

class TrackingPage extends StatefulWidget {
  final String trackingNumber;
  final String sender;
  final String receiver;
  final String address;
  final String weight;

  const TrackingPage({
    super.key,
    required this.trackingNumber,
    required this.sender,
    required this.receiver,
    required this.address,
    required this.weight,
  });

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  GoogleMapController? mapController;

  static const LatLng driverLocation =
      LatLng(-1.6101, 103.6131);

  static const LatLng destinationLocation =
      LatLng(-1.6099, 103.6065);

  final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId("driver"),
      position: driverLocation,
      infoWindow: InfoWindow(
        title: "Mobil Driver",
        snippet: "Sedang berjalan",
      ),
    ),
    const Marker(
      markerId: MarkerId("destination"),
      position: destinationLocation,
      infoWindow: InfoWindow(
        title: "Tujuan Pengiriman",
      ),
    ),
  };

  Future<void> openMaps() async {
    final Uri url = Uri.parse(
      "https://www.google.com/maps/dir/?api=1"
      "&origin=${driverLocation.latitude},${driverLocation.longitude}"
      "&destination=${destinationLocation.latitude},${destinationLocation.longitude}"
      "&travelmode=driving",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 85,
              color: colorScheme.primary,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Lacak Pengiriman",
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    _trackingHeader(context),

                    const SizedBox(height: 16),

                    _map(context),

                    const SizedBox(height: 16),

                    _vehicleCard(context),

                    const SizedBox(height: 16),

                    _routeCard(context),

                    const SizedBox(height: 16),

                    _detailButton(context),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trackingHeader(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: theme.dividerColor,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            Icons.local_shipping,
            color: colorScheme.primary,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.trackingNumber,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "Pengiriman sedang berlangsung",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(.15),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            "Aktif",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _map(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    height: 290,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
    ),
    child: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: driverLocation,
            zoom: 14,
          ),
          markers: markers,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          onMapCreated: (controller) {
            mapController = controller;
          },
        ),

        Positioned(
          top: 12,
          right: 12,
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () {
                mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    driverLocation,
                    15,
                  ),
                );
              },
            ),
          ),
        ),

        Positioned(
          bottom: 14,
          left: 14,
          right: 14,
          child: ElevatedButton.icon(
            onPressed: openMaps,
            icon: const Icon(Icons.navigation),
            label: const Text("Buka Google Maps"),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
Widget _vehicleCard(BuildContext context) {
  return _card(
    context: context,
    title: "Informasi Kendaraan",
    child: Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.local_shipping,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                "Mitsubishi Colt Diesel",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                      fontWeight:
                          FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 5),

              Text(
                "B 1234 ABC",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                      color: Colors.grey,
                    ),
              ),

              const SizedBox(height: 4),

              Text(
                "Truk Box • 4.000 Kg",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _routeCard(BuildContext context) {
  return _card(
    context: context,
    title: "Rute Pengiriman",
    child: Column(
      children: [
        _routeItem(
          context,
          Icons.radio_button_checked,
          Colors.blue,
          "Lokasi Driver",
          "Sedang menuju tujuan",
        ),

        const Padding(
          padding: EdgeInsets.only(
            left: 11,
            top: 4,
            bottom: 4,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 28,
              child: VerticalDivider(
                thickness: 2,
              ),
            ),
          ),
        ),

        _routeItem(
          context,
          Icons.location_on,
          Colors.red,
          "Tujuan",
          widget.receiver,
        ),
      ],
    ),
  );
}

Widget _routeItem(
  BuildContext context,
  IconData icon,
  Color color,
  String title,
  String subtitle,
) {
  return Row(
    crossAxisAlignment:
        CrossAxisAlignment.start,
    children: [
      Icon(
        icon,
        color: color,
        size: 24,
      ),

      const SizedBox(width: 12),

      Expanded(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(
                    color: Colors.grey,
                  ),
            ),

            const SizedBox(height: 2),

            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _detailButton(BuildContext context) {
  final colorScheme =
      Theme.of(context).colorScheme;

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
    ),
    child: SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.receipt_long,
        ),
        label: const Text(
          "Lihat Detail Pengiriman",
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ShipmentDetailPage(
                trackingNumber:
                    widget.trackingNumber,
                sender: widget.sender,
                receiver: widget.receiver,
                address: widget.address,
                weight: widget.weight,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              colorScheme.primary,
          foregroundColor:
              colorScheme.onPrimary,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(14),
          ),
        ),
      ),
    ),
  );
}

Widget _card({
  required BuildContext context,
  required String title,
  required Widget child,
}) {
  final theme = Theme.of(context);

  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
    ),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: theme.cardColor,
      borderRadius:
          BorderRadius.circular(16),
      border: Border.all(
        color: theme.dividerColor,
      ),
      boxShadow: [
        BoxShadow(
          color:
              Colors.black.withOpacity(.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium
              ?.copyWith(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        child,
      ],
    ),
  );
}
}