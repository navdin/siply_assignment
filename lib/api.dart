import 'package:movie_app/app_strings.dart';

class ApiEndPoints {
  ApiEndPoints._();

  static String get baseURL => 'https://api.themoviedb.org/3/';

  static String get getNowPlaying =>
      'movie/now_playing?'
          'api_key=' +
      AppStrings.api_key +
      '&language=en-US&page='; //suffix:pageNumber

  static String get getMovieDetails =>
      'movie/'; //suffix: movieID/ and apikey, language

  static String get getImage =>
      'https://image.tmdb.org/t/p/w300/'; //suffix path

  static String get getOriginalImage => 'https://image.tmdb.org/t/p/original/';
}
