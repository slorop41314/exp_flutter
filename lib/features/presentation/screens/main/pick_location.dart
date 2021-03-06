import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class PickLocation extends StatefulWidget {
  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  Timer? _debounce;
  double _zoomValue = 15;
  Completer<GoogleMapController> _controller = Completer();

  String locationName = "";
  bool isGetLocationLoading = false;

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );

  static final CameraPosition _kLake = CameraPosition(
    // bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    // tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  void initState() {
    super.initState();
    this._getCurrentPosition();
  }

  void _getCurrentPosition() async {
    final res = await this._determinePosition();
    _getLocationName(res.latitude, res.longitude);
    _goToLocation(
      CameraPosition(
        target: LatLng(res.latitude, res.longitude),
        zoom: _zoomValue,
      ),
    );
  }

  // Get current position
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    PermissionStatus permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Permission.location.status;
    if (permission != PermissionStatus.granted) {
      permission = await Permission.location.request();
      // permission = await Geolocator.requestPermission();
      if (permission == PermissionStatus.permanentlyDenied) {
        print("Permission denied");
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == PermissionStatus.denied) {
        print("Permission denied");
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _goToLocation(CameraPosition newPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  void _getLocationName(double lat, double long) async {
    setState(() {
      isGetLocationLoading = true;
    });
    final List<Placemark> response = await placemarkFromCoordinates(lat, long);
    if (response[0].name != null) {
      setState(() {
        locationName = response[0].name!;
      });
    }
    setState(() {
      isGetLocationLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Pick Location"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.terrain,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                    }
                  },
                  myLocationButtonEnabled: true,
                  onCameraMove: (position) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 300), () {
                      _getLocationName(
                        position.target.latitude,
                        position.target.longitude,
                      );
                    });
                  },
                ),
                Center(
                  child: Icon(
                    Icons.pin_drop,
                    color: Colors.lightBlue,
                    size: 50,
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(12.0),
            child: isGetLocationLoading
                ? SizedBox(
                    height: 80,
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Selected location :"),
                      Text(
                        "$locationName",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.done),
                          label: Text("PROCEED"),
                        ),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
