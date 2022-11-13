import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double longitude;
  final double latitude;
  const MapScreen({
    super.key,
    required this.longitude,
    required this.latitude,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('موقع العامل'),
        ),
        body: GoogleMap(
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            compassEnabled: false,
            tiltGesturesEnabled: false,
            markers: {
              Marker(
                markerId: MarkerId(
                    LatLng(widget.latitude, widget.longitude).toString()),
                position: LatLng(widget.latitude, widget.longitude),
              ),
            },
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude, widget.longitude),
              zoom: 15,
            )),
      ),
    );
  }
}
