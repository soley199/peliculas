import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';


class MoviesProvider extends ChangeNotifier{
  String _apyKey = 'c6985b4310bee49b3347a7d1a3054c4f';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _pupolarpage = 0;

  MoviesProvider(){
    print('movieProvider Inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonFata(String endpoint, [int page = 1]) async {
     var url =
      Uri.https(_baseUrl, endpoint, {
        'api_key': _apyKey,
        'language': _language,
        'page': '$page'
        });

      final response = await http.get(url);
      return response.body;

  }
  getOnDisplayMovies() async {
    final jsonData =  await this._getJsonFata('3/movie/now_playing');

  final nowPlayingResponse =NowPlayingResponse.fromJson(jsonData);
  onDisplayMovies = nowPlayingResponse.results;
  notifyListeners();
  }


  getPopularMovies() async{

    _pupolarpage++;

    final jsonData =  await this._getJsonFata('3/movie/popular',_pupolarpage);
    
  final popularResponse = PopularResponse.fromJson(jsonData);
  popularMovies = [...popularMovies,...popularResponse.results];
  //print(popularMovies[0]);
  notifyListeners();

  }
}