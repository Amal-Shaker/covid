import 'package:covid/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailClinic extends StatefulWidget {
  const DetailClinic({Key? key}) : super(key: key);

  @override
  State<DetailClinic> createState() => _DetailClinicState();
}

class _DetailClinicState extends State<DetailClinic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Center(child: Text('Detail the clinic')),
        ),
        body: Consumer<MyProvider>(builder: (context, provider, g) {
          return provider.selected == null
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/images/clinic.png'))),
                      ),
                    ),
                    WidgetRow(
                        keyy: 'clinic name:',
                        value: '${provider.selected!.clinic_name}'),
                    WidgetRow(
                        keyy: 'contract number:',
                        value: '${provider.selected!.contact_number}'),
                    WidgetRow(
                        keyy: 'vaccine brand:',
                        value: '${provider.selected!.vaccine_brand}'),
                    WidgetRow(
                        keyy: 'address:',
                        value: '${provider.selected!.address}'),
                    WidgetRow(
                        keyy: 'latitude:',
                        value: '${provider.selected!.latitude}'),
                    WidgetRow(
                        keyy: 'longitude:',
                        value: '${provider.selected!.longitude}'),
                  ],
                );
        }));
  }
}

class WidgetRow extends StatelessWidget {
  String? keyy;
  String? value;
  WidgetRow({this.keyy, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                height: 60,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  this.keyy!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )))),
        Expanded(
            child: Container(
                height: 60,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(this.value!,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]))))),
      ],
    );
  }
}
