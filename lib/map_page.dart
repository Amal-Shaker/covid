import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:covid/model/clinic.dart';
import 'package:covid/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  // ignore: prefer_const_constructors

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var current_lat;
  var current_long;

  methodPrint() async {
    await Provider.of<MyProvider>(context, listen: false)
        .deathCases!
        .map((e) => print("${e.death_date}|||${e.number_of_death}||||"));
  }

  Set<Marker> myMarker = {};
  @override
  void initState() {
    super.initState();
    current_lat = Provider.of<MyProvider>(context, listen: false)
        .current_position!
        .latitude;
    current_long = Provider.of<MyProvider>(context, listen: false)
        .current_position!
        .longitude;
    List<Clinic> k = Provider.of<MyProvider>(context, listen: false).allClinic!;
    myMarker.addAll(k.map((e) => Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: "${e.clinic_name}"),
        markerId: MarkerId('${e.id}'),
        position: LatLng(
            double.parse('${e.latitude}'), double.parse('${e.longitude}')))));

    myMarker.add(
      Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(title: "your location"),
          markerId: MarkerId('current'),
          position: LatLng(current_lat, current_long)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text(
            'Map',
          ),
        ),
        body: Consumer<MyProvider>(builder: (context, provider, g) {
          return Stack(
            children: [
              Container(
                child: GoogleMap(
                  markers: myMarker,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: provider.current_position == null
                        ? LatLng(68.828629, 120.196005)
                        : LatLng(provider.current_position!.latitude,
                            provider.current_position!.longitude),
                    zoom: 3,
                  ),
                  onMapCreated: (GoogleMapController controller) {},
                ),
              ),
            ],
          );
        }));
  }
}
