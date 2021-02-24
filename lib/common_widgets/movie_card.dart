import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_app/app_strings.dart';
import 'package:movie_app/models/MinorDetails.dart';

import '../api.dart';

class MovieCard extends StatelessWidget {
  MovieCard({this.movie});
  MinorDetails movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      width: 150,
      height: 260,
      color: Color.fromRGBO(13, 37, 63, 1),
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 70,
            child: Container(
              child: Image.network(
                ApiEndPoints.getImage + movie.poster_path,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Flexible(
              fit: FlexFit.tight,
              flex: 30,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      movie.original_title,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      movie.genres,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
