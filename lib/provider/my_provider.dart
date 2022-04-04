import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:covid/api_helper.dart';
import 'package:covid/model/clinic.dart';
import 'package:covid/model/death_case.dart';
import 'package:covid/model/new_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyProvider extends ChangeNotifier {
  List<Clinic>? allClinic;
  List<DeathCase>? deathCases;
  List<NewCase>? newCases;
  Clinic? selected;
  Position? current_position;
  Locale? local;

  setLocal(Locale? localee, BuildContext context) {
    local = EasyLocalization.of(context)!.locale;
    EasyLocalization.of(context)!.setLocale(localee!);
    local = localee;
    notifyListeners();
  }

  getAllClinics() async {
    print('llll');
    List<dynamic> clinics = await ApiHelper.apiHelper.getAllClinic();
    allClinic = clinics.map((e) => Clinic.fromJson(e)).toList();
    print("allClinic$allClinic");
    notifyListeners();
  }

  getAllNewCases() async {
    print('jjj');

    List<dynamic> newCase = await ApiHelper.apiHelper.getAllNewCase();
    newCases = newCase.map((e) => NewCase.fromJson(e)).toList();
    print("newCases$newCases");

    notifyListeners();
  }

  getAllDeathCases() async {
    print('allClinicallClinic');

    List<dynamic> deathCase = await ApiHelper.apiHelper.getAllDeathCase();
    deathCases = deathCase.map((e) => DeathCase.fromJson(e)).toList();
    print("deathCases$deathCases");

    notifyListeners();
  }

  getSingleClinic(dynamic id) async {
    print('allClinicallClinicallClinic');
    dynamic clinicc = await ApiHelper.apiHelper.singleclinic(id);
    selected = Clinic.fromJson(clinicc);
    notifyListeners();
  }

  getLatAndLang() async {
    current_position =
        await Geolocator.getCurrentPosition().then((value) => value);
    notifyListeners();
  }

  getPosition(BuildContext context) async {
    bool services;
    LocationPermission per = await Geolocator.checkPermission();

    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      // ignore: avoid_single_cascade_in_expression_statements
      AwesomeDialog(
          context: context,
          title: "services",
          body: const Text('services Not Enabeled'))
        ..show();
    }
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
      // notifyListeners();
    }
    if (per == LocationPermission.whileInUse ||
        per == LocationPermission.always) {
      await getLatAndLang();
      print('current_positioncurrent_positioncurrent_positioncurrent_position');
      print(current_position);
      notifyListeners();
    }

    print(per);
    notifyListeners();
  }
}
