import 'dart:convert';
import 'package:cinema/models/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MovieModelApi with ChangeNotifier{
  List<MovieModel> MovieData=[];
  bool loading=false;

  Future<void> getData()async{
    final m=await getMovie('tt1375666');
    final m2=await getMovie('tt4154796');
    final m3=await getMovie('tt0114709');
    final m5=await getMovie('tt0396555');
    final m6=await getMovie('tt0468569');

    MovieData.add(m);
    MovieData.add(m2);
    MovieData.add(m3);
    MovieData.add(m5);
    MovieData.add(m6);
    loading=true;
    notifyListeners();


  }

  Future<MovieModel> getMovie(String imdbId) async {
    var uri = Uri.https('movie-details1.p.rapidapi.com', '/imdb_api/movie',
        { "id":imdbId });
    final response = await http.get(uri, headers: {
      "X-RapidAPI-Key": "46c49e9180msh9ad4640826692a3p16acf1jsn831f570ebc19",
      "X-RapidAPI-Host": "movie-details1.p.rapidapi.com",
      "useQueryString": "true"
    });

    final data = jsonDecode(response.body);

    MovieModel M=MovieModel.moviesFromSnapshot(data);
    print(M.image);
    return M;
  }
}