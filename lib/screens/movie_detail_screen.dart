import 'package:flutter/material.dart';
import 'package:movie_app/models/MinorDetails.dart';
import 'package:movie_app/screens/riverpod_test_screen.dart';

import '../api.dart';
import '../constants.dart';

class MovieDetailScreen extends StatefulWidget {
  MovieDetailScreen({this.movieDetails});
  MinorDetails movieDetails;
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backThemeColor,
        appBar: AppBar(
          title: GestureDetector(
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RiverpodTestScreen(
                        movieDetails: widget.movieDetails,
                      );
                    },
                  ),
                );
              },
              child: Text("Movie Details")),
          backgroundColor: backThemeColor,
        ),
        body: ListView(
          children: [
            Image.network(
              ApiEndPoints.getOriginalImage + widget.movieDetails.backdrop_path,
              fit: BoxFit.fill,
              height: 500,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.movieDetails.original_title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 8,
                          fit: FlexFit.tight,
                          child: Wrap(
                            children:
                                widget.movieDetails.genres.split(", ").map((e) {
                              return ActionChip(
                                backgroundColor: backThemeColor,
                                onPressed: () {},
                                label: Text(
                                  e.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.movieDetails.vote_average.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("About",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "Duration: " +
                              ((widget.movieDetails.runtime / 60).round())
                                  .toString() +
                              "hr " +
                              ((widget.movieDetails.runtime % 60) != 0
                                  ? (widget.movieDetails.runtime % 60)
                                          .toString() +
                                      " mins"
                                  : ""),
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.movieDetails.overview,
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ],
        ));
  }
}
