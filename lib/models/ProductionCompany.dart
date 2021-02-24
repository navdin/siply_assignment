class ProductionCompany {
  int id;
  String logo_path;
  String name;
  String origin_country;

  ProductionCompany({this.id, this.logo_path, this.name, this.origin_country});

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'],
      logo_path: json['logo_path'],
      name: json['name'],
      origin_country: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['origin_country'] = this.origin_country;
    if (this.logo_path != null) {
      data['logo_path'] = this.logo_path;
    }
    return data;
  }
}
