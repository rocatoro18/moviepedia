import 'package:dio/dio.dart';
import 'package:moviepedia/config/constants/environment.dart';
import 'package:moviepedia/domain/datasources/movies_datasource.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/infrastructure/mappers/movie_mapper.dart';
import 'package:moviepedia/infrastructure/models/moviedb/moviedb_response.dart';

class MovieDbDatasource extends MoviesDatasource {
  // CLIENTE DE PETICIONES HTTP CONFIGURADO PARA THEMOVIEDB
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    // RECIBIMOS JSON
    final movieDBResponse = MovieDbResponse.fromJson(json);

    // LO MAPEAMOS Y REGRESAMOS UN LISTADO DE MOVIES
    // WHERE, SI LA CONDICION ES CIERTA LO DEJA PASAR, SI ES FALSA, NO. TAMBIEN SE PUEDE PONER ENCADENADO EL WHERE
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }
}
