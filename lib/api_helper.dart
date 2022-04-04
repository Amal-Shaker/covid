import 'dart:convert';
import 'dart:io';

import 'package:covid/model/clinic.dart';
import 'package:dio/dio.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();
  Dio dio = Dio();

  Future<List<dynamic>> getAllClinic() async {
    // String url = "http://10.0.0.57:3000/api_all_clinic.php";
    String url =
        "https://mycoviddashboard.000webhostapp.com/covidapp/api_all_clinic.php";

    Response response = await dio.get(url);
    print("response.statusCode${response.statusCode}");
    List<dynamic> clinics = response.data;
    return clinics;
  }

  Future<dynamic> singleclinic(dynamic id) async {
    // String url = "http://10.0.0.57:3000/api_one_clinic.php?id=$id";
    String url =
        "https://mycoviddashboard.000webhostapp.com/covidapp/api_one_clinic.php?id=$id";

    Response response = await dio.get(url);
    dynamic clinic = response.data;
    print('response.data');
    print(clinic);
    return clinic;
  }

  Future<List<dynamic>> getAllNewCase() async {
    // String url = 'http://10.0.0.57:3000/api_new_case.php';
    String url =
        'https://mycoviddashboard.000webhostapp.com/covidapp/api_new_case.php';

    Response response = await dio.get(url);
    List<dynamic> newCase = response.data;
    return newCase;
  }

  Future<List<dynamic>> getAllDeathCase() async {
    // String url = 'http://10.0.0.57:3000/api_death_case.php';
    String url =
        'https://mycoviddashboard.000webhostapp.com/covidapp/api_death_case.php';

    Response response = await dio.get(url);
    List<dynamic> deathCase = response.data;
    return deathCase;
  }
}
