class DeathCase {
  String? death_date;
  int? number_of_death;

  DeathCase({this.death_date, this.number_of_death});
  DeathCase.fromJson(Map<String, dynamic> json) {
    death_date = json['death_date'];
    number_of_death = json['number_of_death'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['death_date'] = this.death_date;
    data['number_of_cases'] = this.number_of_death;

    return data;
  }
}
