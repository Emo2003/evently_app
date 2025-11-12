import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class CreateEventProvider extends ChangeNotifier {
  CreateEventProvider() {
    log('Created');
    getLocation();
  }

  int selectedTap = 0;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  Set<Marker> markers = {};

  final Location location = Location();

  void changeSelectedTap(int tabIndex) {
    selectedTap = tabIndex;
    notifyListeners();
  }

  DateTime? selectedDate;
  Future<void> chooseDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (newDate != null) {
      selectedDate = newDate;
      notifyListeners();
    }
  }

  TimeOfDay? selectedTime;
  Future<void> chooseTime(BuildContext context) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      selectedTime = newTime;
      notifyListeners();
    }
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

    bool isGpsServiceEnabled = await _checkLocationService();
    if (!isGpsServiceEnabled) return;

    LocationData locationData = await location.getLocation();

    changeCameraPosition(locationData);
    notifyListeners();
  }

  LatLng? eventLocation;
  void changeEventLocation(LatLng location) {
    eventLocation = location;
    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: location,
        infoWindow: const InfoWindow(title: 'Event Location'),
      ),
    );
  }

  String? city;
  String? country;
  Future<void> convertLatLngForEvent() async {
    List<geocoding.Placemark> placeMarks = await geocoding
        .placemarkFromCoordinates(
      eventLocation?.latitude ?? 0,
      eventLocation?.longitude ?? 0,
    );
    if (placeMarks.isNotEmpty) {
      city = placeMarks.first.locality ?? 'UnKnown';
      country = placeMarks.first.country ?? 'UnKnown';
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }
}