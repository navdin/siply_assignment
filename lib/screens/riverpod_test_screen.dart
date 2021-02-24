import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:movie_app/models/MinorDetails.dart';
import 'package:movie_app/state_mgmt/movie_provider.dart';

import '../api.dart';
import '../constants.dart';

class RiverpodTestScreen extends StatefulWidget {
  RiverpodTestScreen({this.movieDetails});
  MinorDetails movieDetails;
  @override
  _RiverpodTestScreenState createState() => _RiverpodTestScreenState();
}

class _RiverpodTestScreenState extends State<RiverpodTestScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
          backgroundColor: backThemeColor,
          appBar: AppBar(
            title: Text("Movie Details"),
            backgroundColor: backThemeColor,
          ),
          body: Consumer(
// Rebuild only the Text when counterProvider updates
              builder: (context, watch, child) {
// Listens to the value exposed by counterProvider
            var state_provider = watch(initialDataProvider.state);
            String genre = context.read(initialDataProvider.state).genrePressed;
            return ListView(
              children: [
                Image.network(
                  ApiEndPoints.getOriginalImage +
                      widget.movieDetails.backdrop_path,
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
                                children: widget.movieDetails.genres
                                    .split(", ")
                                    .map((e) {
                                  return ActionChip(
                                    backgroundColor: backThemeColor,
                                    onPressed: () {
                                      var provider_movies =
                                          context.read(initialDataProvider);
                                      InitialData newData = InitialData();
                                      newData.genrePressed = e.toString();
                                      provider_movies.changeData(newData);
                                    },
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
                            genre + " is pressed",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ],
            );
          })),
    );
  }
}
