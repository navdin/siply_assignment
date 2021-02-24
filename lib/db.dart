import 'dart:async';
//import 'dart:html';
import 'dart:io';
import 'package:movie_app/models/MinorDetails.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:typed_data';

class DBHelper {
  static Database _db;
  static const String DB_NAME = "movie.db";
//  static Database _dbPC;

//  static const String table_OtherLots="OtherLots";
//  static const String table_MyLots="MyLots";
//  static const String table_LikedLots="LikedLots";

  //MovieDetail TABLE
  static const String table_MovieDetail = "MovieDetail";
  //User table columns below
  static const String id = "id";
  static const String localId = "localId";
  static const String backdrop_path = "backdrop_path";
  static const String poster_path = "poster_path";
  static const String genres = "genres";
  static const String original_title = "original_title";
  static const String overview = "overview";
  static const String runtime = "runtime";
  static const String spoken_languages = "spoken_languages";
  static const String vote_average = "vote_average";
  static const String backdrop_localPath = "backdrop_localPath";
  static const String poster_localPath = "poster_localPath";

  //MovieDetail table columns end

  Future<Database> get db async {
    if (_db != null) {
      print('db not null');
      return _db;
    }

    _db = await initDB();
    return _db;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);

    print('DBpath=' + path);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);

    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $table_MovieDetail ($id INTEGER, $localId INTEGER PRIMARY KEY,  $backdrop_path TEXT,  $poster_path TEXT, $genres TEXT, $original_title TEXT, $overview TEXT, "
        "$runtime INTEGER, $vote_average REAL, $spoken_languages TEXT"
        ", $backdrop_localPath TEXT, $poster_localPath TEXT)");
  }

  Future<MinorDetails> saveMovie(MinorDetails details) async {
    //tabke here should be Lots
    try {
      var dbClient = await db;
      details.localId =
          await dbClient.insert(table_MovieDetail, details.toJson());
      return details;
    } catch (e) {
      print('Exception saveMovie below');
      print(e);
      return null;
    }
  }

  Future<MinorDetails> getMovieId(int localId) async {
    try {
      var dbClient = await db;
      List<Map> maps = await dbClient
          .query(table_MovieDetail, where: '$localId=?', whereArgs: [localId]);
      MinorDetails details;
      int len = maps.length;
      if (maps.length > 0) {
        for (int i = 0; i < len; i++) {
          details = MinorDetails.fromJson(maps[i]);
        }
      }
      return details;
    } on Exception catch (e) {
      // TODO
      print(e);
      return null;
    }
  }

  Future<int> deleteMovie(int localId) async {
    try {
      var dbClient = await db;
      return await dbClient
          .delete(table_MovieDetail, where: '$localId=?', whereArgs: [localId]);
    } on Exception catch (e) {
      // TODO
      print(e);
      return null;
    }
  }

  Future<int> updateMovie(MinorDetails details) async {
    try {
      var dbClient = await db;
      return await dbClient.update(table_MovieDetail, details.toJson(),
          where: '$localId=?', whereArgs: [details.localId]);
    } on Exception catch (e) {
      // TODO
      print(e);
      return null;
    }
  }

  Future<MinorDetails> saveImage(MinorDetails details, String type) async {
    //tabke here should be Lots
    try {
      var dbClient = await db;
      details.localId =
          await dbClient.insert(table_MovieDetail, details.toJson());
      return details;
    } catch (e) {
      print('Exception saveMovie below');
      print(e);
      return null;
    }
  }

  Future<List<MinorDetails>> getAllMovies() async {
    try {
      var dbClient = await db;
      List<Map> maps = await dbClient
          .query(table_MovieDetail, where: '$localId>?', whereArgs: [0]);
      List<MinorDetails> list_movies = [];
      int len = maps.length;
      print("len=" + len.toString());
      if (maps.length > 0) {
        for (int i = 0; i < len; i++) {
          list_movies.add(MinorDetails.fromDBJson(maps[i]));
        }
      }
      return list_movies;
    } on Exception catch (e) {
      // TODO
      print(e);
      return null;
    }
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
