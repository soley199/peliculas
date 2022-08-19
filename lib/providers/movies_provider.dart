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

  Map<int, List<Cast>> movieCast = {};

  int _pupolarpage = 0;



  MoviesProvider(){
    print('movieProvider Inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonFata(String endpoint, [int page = 1]) async {
     final url =
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

  Future<List <Cast>> getMovieCast(int movieId) async{
    if(movieCast.containsKey(movieId)) return movieCast[movieId]!;

    //TODO Revisando mapa

    print('Pidiendo info servidor Actores');
    final jsonData =  await this._getJsonFata('3/movie/${movieId}/credits');

    final creditsResponse =CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future <List <Movie>> searchMovie(String query)  async{
    final url = Uri.https(_baseUrl, '3/search/movie', {
        'api_key': _apyKey,
        'language': _language,
        'query': query
        });

        final response = await http.get(url);
      final searchResponse = SearchResponse.fromJson(response.body);

      return searchResponse.results;
  }
}