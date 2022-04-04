import 'package:covid/detail.dart';
import 'package:covid/model/clinic.dart';
import 'package:covid/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class AllClinic extends StatefulWidget {
  const AllClinic({Key? key}) : super(key: key);

  @override
  State<AllClinic> createState() => _AllClinicState();
}

class _AllClinicState extends State<AllClinic> {
  var current_lat;
  var current_long;
  late List<Clinic> o =
      Provider.of<MyProvider>(context, listen: false).allClinic!;
  getDistance() {
    for (int i = 0; i < o.length; i++) {
      o[i].distance = Geolocator.distanceBetween(
              current_lat,
              current_long,
              double.parse('${o[i].latitude}'),
              double.parse('${o[i].longitude}')) /
          1000;
    }
  }

  @override
  void initState() {
    super.initState();
    current_lat = Provider.of<MyProvider>(context, listen: false)
        .current_position!
        .latitude;
    current_long = Provider.of<MyProvider>(context, listen: false)
        .current_position!
        .longitude;
    getDistance();
    o.sort((a, b) => a.distance!.compareTo(b.distance!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('All Clinic sorted')),
          backgroundColor: Colors.green[900],
        ),
        body: Consumer<MyProvider>(
          builder: (context, provider, g) {
            return ListView(
                children: o
                    .map((e) => Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(25)),
                          child: ListTile(
                            onTap: () {
                              provider.getSingleClinic(e.id);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailClinic()));
                            },
                            title: Center(
                              child: Text('${e.clinic_name}'),
                            ),
                          ),
                        ))
                    .toList());
          },
        ));
  }
}
