import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RouteMapWidget extends StatefulWidget {
  final String from; // If "current", use device location
  final String to; // Location name (e.g. "Lagos")
  final String travelMode; // 'driving', 'walking', 'bicycling', 'transit'

  const RouteMapWidget({
    super.key,
    required this.from,
    required this.to,
    this.travelMode = 'driving',
  });

  @override
  State<RouteMapWidget> createState() => _RouteMapWidgetState();
}

class _RouteMapWidgetState extends State<RouteMapWidget> {
  GoogleMapController? _mapController;
  LatLng? fromLatLng;
  LatLng? toLatLng;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};

  final String apiKey = 'AIzaSyATQiPzHvg0zfR_P0u0cVZpfPPsDYyU3OQ';

  @override
  void initState() {
    super.initState();
    _prepareRoute();
  }

  Future<void> _prepareRoute() async {
    // Check location permissions and service status if 'from' is 'current'
    if (widget.from.toLowerCase() == 'current') {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        // Show a message or handle accordingly
        debugPrint('Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions denied, handle appropriately
          debugPrint('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions denied forever
        debugPrint('Location permissions are permanently denied.');
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      fromLatLng = LatLng(position.latitude, position.longitude);
    } else {
      // Geocode 'from' location string to LatLng
      List<Location> fromLocations = await locationFromAddress(widget.from);
      if (fromLocations.isEmpty) {
        debugPrint('Could not find location for from: ${widget.from}');
        return;
      }
      fromLatLng =
          LatLng(fromLocations.first.latitude, fromLocations.first.longitude);
    }

    // Geocode 'to' location string to LatLng
    List<Location> toLocations = await locationFromAddress(widget.to);
    if (toLocations.isEmpty) {
      debugPrint('Could not find location for to: ${widget.to}');
      return;
    }
    toLatLng = LatLng(toLocations.first.latitude, toLocations.first.longitude);

    // After coordinates ready, draw route
    _drawRoute();
  }

  Future<void> _drawRoute() async {
    if (fromLatLng == null || toLatLng == null) return;

    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(fromLatLng!.latitude, fromLatLng!.longitude),
        destination: PointLatLng(toLatLng!.latitude, toLatLng!.longitude),
        mode: _getTravelMode(widget.travelMode),
      ),
      googleApiKey: apiKey,
    );

    if (result.points.isNotEmpty) {
      setState(() {
        polylines = {
          Polyline(
            polylineId: const PolylineId('route'),
            color: Colors.blue,
            width: 5,
            points: result.points
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          ),
        };

        markers = {
          Marker(
            markerId: const MarkerId('from'),
            position: fromLatLng!,
            infoWindow: InfoWindow(title: 'From', snippet: widget.from),
          ),
          Marker(
            markerId: const MarkerId('to'),
            position: toLatLng!,
            infoWindow: InfoWindow(title: 'To', snippet: widget.to),
          ),
        };
      });

      // Fit map to bounds
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          fromLatLng!.latitude < toLatLng!.latitude
              ? fromLatLng!.latitude
              : toLatLng!.latitude,
          fromLatLng!.longitude < toLatLng!.longitude
              ? fromLatLng!.longitude
              : toLatLng!.longitude,
        ),
        northeast: LatLng(
          fromLatLng!.latitude > toLatLng!.latitude
              ? fromLatLng!.latitude
              : toLatLng!.latitude,
          fromLatLng!.longitude > toLatLng!.longitude
              ? fromLatLng!.longitude
              : toLatLng!.longitude,
        ),
      );

      _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));
    }
  }

  TravelMode _getTravelMode(String mode) {
    switch (mode.toLowerCase()) {
      case 'walking':
        return TravelMode.walking;
      case 'bicycling':
        return TravelMode.bicycling;
      case 'transit':
        return TravelMode.transit;
      case 'driving':
      default:
        return TravelMode.driving;
    }
  }

  @override
  Widget build(BuildContext context) {
    return fromLatLng == null || toLatLng == null
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: fromLatLng!,
              zoom: 12,
            ),
            polylines: polylines,
            markers: markers,
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          );
  }
}
