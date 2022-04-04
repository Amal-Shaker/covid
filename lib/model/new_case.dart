class NewCase {
  String? date_case;
  num? number_of_cases;

  NewCase({this.date_case, this.number_of_cases});
  NewCase.fromJson(Map<String, dynamic> json) {
    date_case = json['date_case'];
    number_of_cases = json['number_of_cases'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['date_case'] = this.date_case;
    data['number_of_cases'] = this.number_of_cases;

    return data;
  }
}
