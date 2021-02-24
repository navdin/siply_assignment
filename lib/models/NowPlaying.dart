import 'Dates.dart';
import 'Result.dart';

class NowPlaying {
  Dates dates;
  int page;
  List<Result> results;
  int total_pages;
  int total_results;

  NowPlaying(
      {this.dates,
      this.page,
      this.results,
      this.total_pages,
      this.total_results});

  factory NowPlaying.fromJson(Map<String, dynamic> json) {
    return NowPlaying(
      dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
      page: json['page'],
      results: json['results'] != null
          ? (json['results'] as List).map((i) => Result.fromJson(i)).toList()
          : null,
      total_pages: json['total_pages'],
      total_results: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_pages'] = this.total_pages;
    data['total_results'] = this.total_results;
    if (this.dates != null) {
      data['dates'] = this.dates.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
