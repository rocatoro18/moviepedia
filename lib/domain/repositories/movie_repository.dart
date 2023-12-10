import 'package:moviepedia/domain/entities/movie.dart';

// REPOSITORIO LLAMARA AL DATASOURCE
abstract class MovieRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
