import 'package:evently_app/core/providers/LocationProvider.dart';
import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:evently_app/screens/home/tabs/MapTab/widgets/list_of_event.dart';
import 'package:evently_app/services/Firebase_storageManager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/resourse/RouteManager.dart';
import '../../../../models/EventModel.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    LocationProvider provider = Provider.of<LocationProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          provider.getLocation();
        },
        child: Icon(Icons.gps_fixed_outlined, size: 30),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  markers: provider.markers,
                  initialCameraPosition: provider.cameraPosition,
                  mapType: MapType.normal,
                  onMapCreated: (controller) =>
                      provider.mapController = controller,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 160,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) =>ListOfEvents( event: provider.events[index],),
              separatorBuilder: (_,_)=>SizedBox(width: 2,),
              itemCount: provider.events.length,
            ),
          ),
        ],
      ),
    );
  }
}
