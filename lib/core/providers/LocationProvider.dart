import 'dart:async';

import 'package:evently_app/services/Firebase_storageManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../models/EventModel.dart';

class LocationProvider extends ChangeNotifier {
  final Location location = Location();
  late final StreamSubscription<LocationData> _locationStream;
  late GoogleMapController mapController;

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );
  Set<Marker> markers = {};

  void setLocationListener(){
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 900);
   _locationStream = location.onLocationChanged.listen((LocationData currentLocation) {
      changeCameraPosition(currentLocation);
      notifyListeners();
    });
  }
  final List<Event> events = [];
  Future<void> getAllEvents() async {
    List<Event> firestoreEvents = await FirebaseStorageManager.getAllEvent();
    events.addAll(firestoreEvents);
    notifyListeners();
  }

  Future<bool> _getLocationPermission() async {
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    return permissionGranted == PermissionStatus.granted;
  }

  Future<bool> _checkLocationService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }
  changeCameraPosition(LocationData locationData){
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 14,
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
    markers.add(
      Marker(
          markerId: (MarkerId("1")),
          position: LatLng(
            locationData.latitude ?? 0,
            locationData.longitude ?? 0,
          ),
          infoWindow: InfoWindow(
            title: "My Current Location",
            snippet: "My Current Location",
          )
      ),
    );
  }
  Future<void> getLocation() async {
    bool isPermissionGranted = await _getLocationPermission();
    if (!isPermissionGranted) return;

    bool isGpsEnabled = await _checkLocationService();
    if (!isGpsEnabled) return;

    LocationData locationData = await location.getLocation();
    changeCameraPosition(locationData);
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mapController.dispose();
    _locationStream.cancel();
    super.dispose();
  }
}
