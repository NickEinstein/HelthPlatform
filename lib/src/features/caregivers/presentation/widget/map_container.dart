import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class MapContainer extends StatefulWidget {
  final String name;
  final String location;

  const MapContainer({
    Key? key,
    required this.name,
    required this.location,
  }) : super(key: key);

  @override
  State<MapContainer> createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  LatLng? targetLocation;
  bool loading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _getCoordinatesFromAddress();
  }

  Future<void> _getCoordinatesFromAddress() async {
    try {
      // Timeout after 10 seconds
      final locations = await locationFromAddress(widget.location)
          .timeout(const Duration(seconds: 10));

      if (!mounted) return;

      if (locations.isNotEmpty) {
        setState(() {
          targetLocation = LatLng(
            locations.first.latitude,
            locations.first.longitude,
          );
          loading = false;
        });
      } else {
        throw Exception('No location found');
      }
    } catch (e) {
      debugPrint('Geocoding failed: $e');
      if (!mounted) return;
      setState(() {
        hasError = true;
        loading = false;
      });
    }
  }

  void openMapWithAddress(String address) async {
    final query = Uri.encodeComponent(address);
    final url = 'https://www.google.com/maps/search/?api=1&query=$query';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Couldn't open map.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : hasError || targetLocation == null
              ? Center(
                  child: Text(
                    'Unable to load map for "${widget.location}"',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                )
              : Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: targetLocation!,
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('target'),
                          position: targetLocation!,
                          infoWindow: InfoWindow(
                            title: widget.name,
                            snippet: widget.location,
                            onTap: () => openMapWithAddress(widget.location),
                          ),
                        ),
                      },
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      onMapCreated: (controller) {},
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white.withOpacity(0.9),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.location,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                              textAlign: TextAlign.center,
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
