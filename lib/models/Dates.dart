class Dates {
    String maximum;
    String minimum;

    Dates({this.maximum, this.minimum});

    factory Dates.fromJson(Map<String, dynamic> json) {
        return Dates(
            maximum: json['maximum'], 
            minimum: json['minimum'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['maximum'] = this.maximum;
        data['minimum'] = this.minimum;
        return data;
    }
}