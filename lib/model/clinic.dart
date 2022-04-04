class Clinic {
  String? id;
  String? clinic_name;
  String? contact_number;
  String? address;
  String? longitude;
  String? latitude;
  double? distance;
  String? vaccine_brand;

  Clinic(
      {this.id,
      this.clinic_name,
      this.contact_number,
      this.address,
      this.longitude,
      this.latitude,
      this.distance = 0,
      this.vaccine_brand});

  Clinic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinic_name = json['clinic_name'];
    contact_number = json['contact_number'];
    address = json['address'];
    vaccine_brand = json['vaccine_brand'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    distance = json['distance'] = 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clinic_name'] = this.clinic_name;
    data['contact_number'] = this.contact_number;
    data['address'] = this.address;
    data['vaccine_brand'] = this.vaccine_brand;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['distance'] = this.distance;

    return data;
  }
}
