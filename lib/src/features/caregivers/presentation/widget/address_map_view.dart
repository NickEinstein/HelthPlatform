// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';

// class AddressMapView extends StatefulWidget {
//   final String address;

//   const AddressMapView({super.key, required this.address});

//   @override
//   State<AddressMapView> createState() => _AddressMapViewState();
// }

// class _AddressMapViewState extends State<AddressMapView> {
//   LatLng? _location;
//   GoogleMapController? _controller;

//   @override
//   void initState() {
//     super.initState();
//     _getCoordinates();
//   }

//   Future<void> _getCoordinates() async {
//     try {
//       final locations = await locationFromAddress(widget.address);
//       if (locations.isNotEmpty) {
//         final loc = locations.first;
//         setState(() {
//           _location = LatLng(loc.latitude, loc.longitude);
//         });
//       }
//     } catch (e) {
//       print('Error converting address: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.address)),
//       body: _location == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: _location!,
//                 zoom: 15,
//               ),
//               markers: {
//                 Marker(
//                   markerId: const MarkerId('addressMarker'),
//                   position: _location!,
//                   infoWindow: InfoWindow(title: widget.address),
//                 ),
//               },
//               onMapCreated: (controller) => _controller = controller,
//             ),
//     );
//   }
// }
