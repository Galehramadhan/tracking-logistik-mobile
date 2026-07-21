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
  State<TrackingPage> createState() =>
      _TrackingPageState();
}

class _TrackingPageState
    extends State<TrackingPage> {

  GoogleMapController? mapController;

  static const LatLng driverLocation =
      LatLng(-1.6101, 103.6131);

  static const LatLng destinationLocation =
      LatLng(-1.6099, 103.6065);

  final Set<Marker> markers = {

    const Marker(
      markerId: MarkerId('driver'),
      position: driverLocation,
      infoWindow: InfoWindow(
        title: 'Mobil Driver',
        snippet: 'Sedang berjalan',
      ),
    ),

    const Marker(
      markerId: MarkerId('destination'),
      position: destinationLocation,
      infoWindow: InfoWindow(
        title: 'Tujuan Pengiriman',
      ),
    ),
  };

  Future<void> openMaps() async {

    final Uri url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&origin=${driverLocation.latitude},'
      '${driverLocation.longitude}'
      '&destination=${destinationLocation.latitude},'
      '${destinationLocation.longitude}'
      '&travelmode=driving',
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
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 6, 8, 11),

      body: SafeArea(
        child: Column(
          children: [

            // HEADER
            Container(
              height: 85,
              color: const Color(0xff0755C9),
              child: Row(
                children: [

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        'Lacak Pengiriman',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
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

                    _trackingHeader(),

                    const SizedBox(height: 14),

                    _map(),

                    const SizedBox(height: 14),

                    _vehicleCard(),

                    const SizedBox(height: 14),

                    _routeCard(),

                    const SizedBox(height: 14),

                    _detailButton(),

                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trackingHeader() {
    return Container(
      margin:
          const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:  const Color.fromARGB(255, 40, 31, 31),
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Row(
        children: [

          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xffE8F1FF),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.local_shipping,
              color: Color(0xff0755C9),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  widget.trackingNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  'Pengiriman sedang berlangsung',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffE8F7ED),
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: const Text(
              'Aktif',
              style: TextStyle(
                color: Colors.green,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _map() {
    return Container(
      margin:
          const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      height: 280,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Stack(
        children: [

          GoogleMap(
            initialCameraPosition:
                const CameraPosition(
              target: driverLocation,
              zoom: 14,
            ),
            markers: markers,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),

          Positioned(
            bottom: 12,
            right: 12,
            child: ElevatedButton.icon(
              onPressed: openMaps,
              icon: const Icon(
                Icons.navigation,
                color: Colors.white,
              ),
              label: const Text(
                'Buka Google Maps',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xff0755C9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _vehicleCard() {
    return _card(
      title: 'Informasi Kendaraan',
      child: Row(
        children: [

          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xffE8F1FF),
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.local_shipping,
              color: Color(0xff0755C9),
              size: 32,
            ),
          ),

          const SizedBox(width: 14),

          const Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                'Mitsubishi Colt Diesel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 5),

              Text(
                'B 1234 ABC',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 4),

              Text(
                'Truk Box • 4.000 Kg',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _routeCard() {
    return _card(
      title: 'Rute Pengiriman',
      child: Column(
        children: [

          _routeItem(
            Icons.radio_button_checked,
            Colors.blue,
            'Lokasi Driver',
            'Sedang menuju tujuan',
          ),

          const SizedBox(height: 15),

          _routeItem(
            Icons.location_on,
            Colors.red,
            'Tujuan',
            widget.receiver,
          ),
        ],
      ),
    );
  }

  Widget _routeItem(
    IconData icon,
    Color color,
    String title,
    String subtitle,
  ) {
    return Row(
      children: [

        Icon(
          icon,
          color: color,
        ),

        const SizedBox(width: 12),

        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              subtitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _detailButton() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
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
          style:
              ElevatedButton.styleFrom(
            backgroundColor:
                const Color(0xff0755C9),
          ),
          child: const Text(
            'Lihat Detail Pengiriman',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _card({
    required String title,
    required Widget child,
  }) {
    return Container(
      margin:
          const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:  const Color.fromARGB(255, 40, 31, 31),
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xffE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 15),

          child,
        ],
      ),
    );
  }
}