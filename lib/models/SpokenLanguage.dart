class SpokenLanguage {
  String english_name;
  String iso_639_1;
  String name;

  SpokenLanguage({this.english_name, this.iso_639_1, this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      english_name: json['english_name'],
      iso_639_1: json['iso_639_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['english_name'] = this.english_name;
    data['iso_639_1'] = this.iso_639_1;
    data['name'] = this.name;
    return data;
  }
}
