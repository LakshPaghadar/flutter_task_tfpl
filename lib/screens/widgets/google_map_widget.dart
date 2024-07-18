import 'dart:async';

import 'package:dummy_api_call_retrofit/screens/model/geofencing_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../generated/l10n.dart';

class GoogleMapWidget extends StatefulWidget {
  GeofencingLocation selectedLocation;
  GoogleMapWidget({super.key, required this.selectedLocation});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? mapController;
  Completer<GoogleMapController> _controller = Completer();
  final ValueNotifier<int> _radiusNotifier = ValueNotifier(1);

  //21.776427632427282, 70.13049313523027
  double? _currentLat;
  double? _currentLong;

  @override
  void initState() {
    _currentLat = widget.selectedLocation.latitude;
    _currentLong = widget.selectedLocation.latitude;
    setLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      circles: {
        Circle(
          circleId: CircleId('geo_fence_1'),
          center: LatLng(
            widget.selectedLocation.latitude,
            widget.selectedLocation.longitude,
          ),
          radius: widget.selectedLocation.distance * 100,
          strokeWidth: 2,
          strokeColor: Colors.green,
          fillColor: Colors.green.withOpacity(0.15),
        ),
      },
      onMapCreated: (controller) {
        _controller.complete(controller);
        mapController = controller;
      },
      markers: _createMarkers(),
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.selectedLocation.latitude,
            widget.selectedLocation.longitude),
        zoom: 14.0,
      ),
    );
  }

  void setLocation() async {
    mapController = await _controller.future;
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(widget.selectedLocation.latitude,
              widget.selectedLocation.longitude),
          zoom: 14.0,
        ),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(widget.selectedLocation.latitude,
            widget.selectedLocation.longitude),
        infoWindow: InfoWindow(title: S.of(context).yourLocation),
      ),
    };
  }
}
