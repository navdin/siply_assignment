class MinorDetails {
  int localId;
  int id;
  String backdrop_path;
  String genres;
  String original_title;
  String overview;
  String poster_path;
  int runtime;
  String spoken_languages;
  String backdrop_localPath;
  String poster_localPath;
  double vote_average;

  MinorDetails(
      {this.localId,
      this.id,
      this.backdrop_path,
      this.genres,
      this.original_title,
      this.overview,
      this.poster_path,
      this.runtime,
      this.spoken_languages,
      this.poster_localPath,
      this.backdrop_localPath,
      this.vote_average});

  factory MinorDetails.fromDBJson(Map<String, dynamic> json) {
    return MinorDetails(
      localId: json['localId'],
      id: json['id'],
      backdrop_path: json['backdrop_path'],
      genres: json['genres'],
      original_title: json['original_title'],
      overview: json['overview'],
      poster_path: json['poster_path'],
      runtime: json['runtime'],
      spoken_languages: json['spoken_languages'],
      backdrop_localPath: json['backdrop_localPath'],
      poster_localPath: json['poster_localPath'],
      vote_average: json['vote_average'],
    );
  }

  factory MinorDetails.fromJson(Map<String, dynamic> json) {
    return MinorDetails(
      localId: json['localId'],
      id: json['id'],
      backdrop_path: json['backdrop_path'],
      // genres: json['genres'],
      original_title: json['original_title'],
      overview: json['overview'],
      poster_path: json['poster_path'],
      runtime: json['runtime'],
      // spoken_languages: json['spoken_languages'],
      backdrop_localPath: json['backdrop_localPath'],
      poster_localPath: json['poster_localPath'],
      vote_average: json['vote_average'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['localId'] = this.localId;
    data['id'] = this.id;
    data['backdrop_path'] = this.backdrop_path;
    data['genres'] = this.genres;
    data['original_title'] = this.original_title;
    data['overview'] = this.overview;
    data['poster_path'] = this.poster_path;
    data['runtime'] = this.runtime;
    data['spoken_languages'] = this.spoken_languages;
    data['backdrop_localPath'] = this.backdrop_localPath;
    data['poster_localPath'] = this.poster_localPath;
    data['vote_average'] = this.vote_average;
    return data;
  }
}
