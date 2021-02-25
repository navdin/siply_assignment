import 'dart:io';
import 'package:dio/dio.dart';
import 'package:movie_app/api.dart';
import 'package:movie_app/app_strings.dart';
import 'package:movie_app/db.dart';
import 'package:movie_app/models/MinorDetails.dart';
import 'package:path_provider/path_provider.dart';

Network networkGlobal = new Network();

class Network {
  Network();

  Future<dynamic> serverCall(Map params) async {
    print('before http sign in call');

    // if (params["acessToken"] == null) {
    //   await getAccessToken();
    // }

//    accessToken =
//        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjIyNTUxODkxRkNBMTUyNjk1OEY1OENGQzNEQTYzNzkyIiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2MDM1MzQ1MzksImV4cCI6MTYwMzUzODEzOSwiaXNzIjoiaHR0cHM6Ly9hYWxncm8taWRlbnRpdHktYXBwLWRldi5henVyZXdlYnNpdGVzLm5ldCIsImF1ZCI6Imh0dHBzOi8vYWFsZ3JvLWlkZW50aXR5LWFwcC1kZXYuYXp1cmV3ZWJzaXRlcy5uZXQvcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiYzVhNGJmODctYWUzZS00YmQ0LTZkNDMtMDhkODZiYWFiYTM0Iiwic3ViIjoiYTNmYjk3ZmMtYzQ3OC00YWEwLTk3ZmEtNWE5ZTBlMjUzMDZhIiwiYXV0aF90aW1lIjoxNjAzNTM0NTM2LCJpZHAiOiJsb2NhbCIsIm5hbWUiOiJOYXZpbiBEaW5lc2giLCJnaXZlbl9uYW1lIjoiTmF2aW4iLCJmYW1pbHlfbmFtZSI6IkRpbmVzaCIsImVtYWlsIjoibmF2aW5AYWFsZ3JvLmNvbSIsInBob25lX251bWJlciI6Ijk2NDI3OTYzMTQiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuYXZpbkBhYWxncm8uY29tIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjpmYWxzZSwicm9sZSI6WyJCQVNJQ19VU0VSX1JFQUQiLCJCQVNJQ19VU0VSX1dSSVRFIiwiU1VQRVJfQURNSU4iXSwiY29tcGFueV9pZCI6MSwianRpIjoiQjA5NkMyNEYzQTIzRDJFMEUyRkY2OTZCMjc1NjNBQzQiLCJzaWQiOiJDRDBBM0JFQjE1MEU5NkI2NTMzRUFGMzk3OEYyMjIzNiIsImlhdCI6MTYwMzUzNDUzOSwic2NvcGUiOlsib3BlbmlkIiwicHJvZmlsZSIsImVtYWlsIiwicGhvbmUiLCJyb2xlcyIsImNvbXBhbnlpbmZvIiwiSWRlbnRpdHlTZXJ2ZXJBcGkiLCJhYWxncm8tdHJhZGUtYXBpIl0sImFtciI6WyJwd2QiXX0.YU28-eBN6mYRq9gwDxR8jszmtBciQsfxthBoKTY_dVQMeHghNR1cvKI_0kqajAPY4lDDJ9Ue224FtMZZGBMnOj4uyU19pLvroncfBLcXPhvK71NLZsjtw5xWfcd5b5fu2mdntxCGQM3B9mQ7lKtH_1v-JNBhWitZLVQ-gbPeSj0lfQrr8OKxTfePA0I5BvX-gXU-IbLvxS32rEN8G_Z04OP6r82TjThcJrWMpF2JDDlT2ErEHPJbKdr0QgGKCfbvCEg3PjtyCxFs2QVa6gUFQZ4j-GxV8cBq8zJE-fHSIKHJkqbNIno7h-JTp1_jv1IoKwY4QYRpnNOkRQUCVzIx0g";

    Response res = null;
    try {
      res = await Dio()
          .request(
            params["baseURL"] != null
                ? params["baseURL"] + params["suffix"]
                : ApiEndPoints.baseURL + params["suffix"],

            data: params["body"],
            options: Options(
              method: params["method"],
              headers: {
                //   HttpHeaders.authorizationHeader:
                //       "Bearer " + loginModel.accessToken,
                HttpHeaders.contentTypeHeader: params["contentTypeHeader"]
              },
            ), // // set responseType to `bytes`
          )
          .timeout(new Duration(
            seconds: params["timeout"],
          ));
    } on DioError catch (e) {
      print('exception ' + e.message.toString());
      if (e.message.contains("403")) {
        print('reached 403');
        print(e.response.data);
        return Future.error("Session expired.");
      }
      if (e.message.contains("400")) {
        return Future.error("Incorrect username or password");
      }
      if (e.message.contains("401")) {
        return Future.error("invalid token");
      }
      return Future.error(e.message.toString());
    }

    print('res.body below');
    if (res.statusCode == 200) {
      return res;
    } else {
      return false;
    }
  }

  Future<dynamic> getNowPlaying(int pageNo) async {
    try {
      Map mapNowPlaying = {
        "method": "GET",
        "suffix": ApiEndPoints.getNowPlaying + pageNo.toString(),
        "contentTypeHeader": "application/json",
        "timeout": 50,
      };
      Response res = await serverCall(mapNowPlaying).catchError((error) {
        return Future.error(error.toString());
      });
      List<MinorDetails> listNowPlaying = [];
      int i = 0;
      for (Map e in res.data["results"]) {
        // if (i == 6) {
        //   break;
        // }
        i++;
        print("i= " + i.toString());
        try {
          MinorDetails detail;
          try {
            detail = MinorDetails.fromJson(e);
          } catch (e) {
            print(e.toString());
          }
          detail = await getMovieDetails(detail.id, detail);
          DBHelper dbHelper = DBHelper();
          await dbHelper.saveMovie(detail);
          // await getImage(detail.poster_path, "poster", detail);
          listNowPlaying.add(detail);
        } catch (e) {
          print(e.toString());
        }
      }

      print("listNowPlaying.length=" + listNowPlaying.length.toString());
      return listNowPlaying;
    } catch (e) {
      print("error below=");
      print(e.toString());
    }
  }

  Future<dynamic> getMovieDetails(
      int movieId, MinorDetails movieDetailsMain) async {
    try {
      Map getDetails = {
        "method": "GET",
        "suffix": ApiEndPoints.getMovieDetails +
            movieId.toString() +
            '?'
                'api_key=' +
            AppStrings.api_key +
            '&language=en-US',
        "contentTypeHeader": "application/json",
        "timeout": 50,
      };
      Response res = await serverCall(getDetails).catchError((error) {
        return Future.error(error.toString());
      });
      List<String> genres = [];
      List<String> spoken_languages = [];
      try {
        MinorDetails movieDetails = MinorDetails.fromJson(res.data);

        movieDetails.id = movieDetailsMain.id;
        List mapGenres = res.data["genres"];
        for (Map map in mapGenres) {
          genres.add(map["name"]);
        }
        List mapSpoken = res.data["spoken_languages"];
        for (Map map in mapSpoken) {
          spoken_languages.add(map["english_name"]);
        }

        movieDetails.genres = genres.join(", ");
        movieDetails.spoken_languages = spoken_languages.join(", ");
        movieDetailsMain = movieDetails;
        // await getImage(movieDetails.backdrop_path, "backdrop", movieDetails);
      } catch (e) {
        print("getMovieDetails=error");
        print(e.toString());
      }
    } catch (ex) {
      print("ex" + ex);
    }
    return movieDetailsMain;
  }

  Future<dynamic> getMovieDetails2(int movieId) async {
    Map getDetails = {
      "method": "GET",
      "suffix": ApiEndPoints.getMovieDetails +
          movieId.toString() +
          '?'
              'api_key=' +
          AppStrings.api_key +
          '&language=en-US',
      "contentTypeHeader": "application/json",
      "timeout": 10,
    };
    Response res = await serverCall(getDetails).catchError((error) {
      return Future.error(error.toString());
    });
    MinorDetails movieDetails = MinorDetails.fromJson(res.data);

    // await getImage(movieDetails.backdrop_path, "backdrop", movieDetails);

    return movieDetails;
  }

  Future<dynamic> getImage(
      String imageId, String type, MinorDetails details) async {
    Map mapGetImage = {
      "method": "GET",
      "baseURL": "",
      "suffix": ApiEndPoints.getImage + imageId,
      "contentTypeHeader": "image/jpeg",
      "timeout": 10,
    };
    Response res = await serverCall(mapGetImage).catchError((error) {
      return Future.error(error.toString());
    });

    String mediaPath = await getLocalPath();

    String imageLocalPath =
        mediaPath + "/" + details.localId.toString() + "/" + type;
    new File(imageLocalPath).createSync(recursive: true);
//    new File(singleSysPath).createSync(recursive: true);
    File file = new File(imageLocalPath);
//        File fileSys = new File(singleSysPath);

    // Base64Decoder base64decoder = new Base64Decoder();
    // file.writeAsBytesSync(base64decoder.convert(res.data));

    // var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    // raf.writeStringSync(res.data);
    print("image type below");
    print(res.data.runtimeType);
    // file.writeAsStringSync(res.data.base64str
    //     .replaceAll(RegExp(r'^data:image\/[a-z]+;base64,'), ''));

    // raf.writeB(Uint8List.fromList(base64Decode(res.data)));

    // await raf.close();
    //(res.body);
    print("imageLocalPath=" + imageLocalPath);
    print("mediaUrl and length below");
    if (type == "poster") {
      details.poster_localPath = imageLocalPath;
    } else {
      details.backdrop_localPath = imageLocalPath;
    }
    DBHelper dbHelper = new DBHelper();
    await dbHelper.saveMovie(details);

    return res.data;
  }

  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();

    print('path found' + directory.path);
    return directory.path;
  }
}
