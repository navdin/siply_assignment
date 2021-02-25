import 'package:flutter/material.dart';
import 'package:movie_app/common_widgets/movie_card.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/db.dart';
import 'package:movie_app/models/MinorDetails.dart';
import 'package:movie_app/models/MovieDetail.dart';
import 'package:movie_app/network.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';

class NowPlayingScreen extends StatefulWidget {
  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  List<MinorDetails> listNowMovies = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Now Playing"),
          backgroundColor: backThemeColor,
        ),
        body: FutureBuilder(
          future: getNowPlaying(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return snapshot.data;
              }
              return snapshot.data;
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  getNowPlaying() async {
    DBHelper dbHelper = new DBHelper();
    if (listNowMovies == null || listNowMovies.length == 0) {
      listNowMovies = await dbHelper.getAllMovies();
      if (listNowMovies == null || listNowMovies.length == 0) {
        listNowMovies = await Network().getNowPlaying(1);
        print("listNowMovies.length");
      }
    }
    double width = MediaQuery.of(context).size.width / 2;
    double height = width * 1.7;
    return SingleChildScrollView(
      child: Wrap(
          spacing: 0,
          alignment: WrapAlignment.center,
          children: listNowMovies.map((e) {
            return GestureDetector(
              child: MovieCard(
                movie: e,
                height: height,
                width: width,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetailScreen(
                        movieDetails: e,
                      );
                    },
                  ),
                );
              },
            );
          }).toList()),
    );
  }
}
