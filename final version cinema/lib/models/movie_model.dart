import 'package:flutter/material.dart';
import 'package:cinema/models/cast_model.dart';

class MovieModel{
  String id;
  String name;
  String genre;
  num rating;
  String runtime;
  String storyLine;
  String image;
  //Image imageLogo;
  //List<MovieCastModel> castList = [];

  MovieModel ({
    required this.id,
    required this.genre,
    required this.name,
    required this.rating,
    required this.runtime,
    required this.storyLine,
    required this.image,
    //required this.imageLogo,
    //this.castList,
  });

  factory MovieModel.fromJson(dynamic json) {
    return MovieModel(
        id: json['id'] as String,
        genre: json['genres'][0] as String,
        name: json['title'] as String,
        rating: json['rating'] as num,
        runtime: json['runtime'] as String,
        storyLine: json['description'] as String,
        image: json['image'] as String,
    );
        //castList: json['castList'] as List<MovieCastModel>);
  }

  static MovieModel moviesFromSnapshot(Map snapshot) {

    return MovieModel.fromJson(snapshot);

  }
}