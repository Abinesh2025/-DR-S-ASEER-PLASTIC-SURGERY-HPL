import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? _mapController;

  // Kept Nagercoil default as per previous request, it doesn't require billing
  LatLng _lastMapPosition = const LatLng(8.1833, 77.4119);
  String _address = "Nagercoil";
  String _city = "Nagercoil";
  String _pincode = "";

  @override
  void initState() {
    super.initState();
    _getAddressFromLatLng(_lastMapPosition);
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    debugPrint("[LocationPicker] Starting _determinePosition...");
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("[LocationPicker] Location services are disabled.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("[LocationPicker] Permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("[LocationPicker] Permission denied forever.");
      return;
    }

    try {
      // 1. Force a small delay to ensure the map widget/controller is likely to be ready
      await Future.delayed(const Duration(milliseconds: 500));

      // 2. Try to get last known position first (fast)
      Position? lastPosition = await Geolocator.getLastKnownPosition();
      if (lastPosition != null && mounted) {
        debugPrint("[LocationPicker] Using last known position: $lastPosition");
        setState(() {
          _lastMapPosition =
              LatLng(lastPosition.latitude, lastPosition.longitude);
        });
        _mapController?.animateCamera(CameraUpdate.newLatLng(_lastMapPosition));
        _getAddressFromLatLng(_lastMapPosition);
      }

      // 3. Try to get current position with timeout
      debugPrint("[LocationPicker] Fetching accurate current position...");
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 15),
      );

      if (!mounted) return;

      debugPrint(
          "[LocationPicker] Successfully fetched current position: $position");
      setState(() {
        _lastMapPosition = LatLng(position.latitude, position.longitude);
      });

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(_lastMapPosition),
        );
      }

      _getAddressFromLatLng(_lastMapPosition);
    } catch (e) {
      debugPrint("[LocationPicker] Error fetching current position: $e");
    }
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _address = "${place.street}, ${place.name}, ${place.subLocality}";
          _city = "${place.locality}";
          _pincode = "${place.postalCode}";
        });
      }
    } catch (e) {
      debugPrint("Error reverse geocoding: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location",
            style: TextStyleConst.boldTextStyle(Colors.black, 18)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _lastMapPosition,
              zoom: 15,
            ),
            onCameraMove: _onCameraMove,
            onCameraIdle: () {
              _getAddressFromLatLng(_lastMapPosition);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: Icon(Icons.location_on,
                  size: 50, color: ColorConst.primaryColor),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4))
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_city, color: Colors.grey, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _address,
                          style:
                              TextStyleConst.mediumTextStyle(Colors.black, 14),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(result: {
                          'address': _address,
                          'city': _city,
                          'pincode': _pincode,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConst.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: Text("Confirm Delivery Location",
                          style:
                              TextStyleConst.boldTextStyle(Colors.white, 16)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
