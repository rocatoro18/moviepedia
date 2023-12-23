import 'package:dio/dio.dart';
import 'package:moviepedia/config/constants/environment.dart';
import 'package:moviepedia/domain/datasources/actors_datasource.dart';
import 'package:moviepedia/domain/entities/actor.dart';
import 'package:moviepedia/infrastructure/mappers/actor_mapper.dart';
import 'package:moviepedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  // CLIENTE DE PETICIONES HTTP CONFIGURADO PARA THEMOVIEDB
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
