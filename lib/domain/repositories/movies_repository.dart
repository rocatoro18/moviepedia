import 'package:moviepedia/domain/entities/movie.dart';

// REPOSITORIO LLAMARA AL DATASOURCE
abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
}
