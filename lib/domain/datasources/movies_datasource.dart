import 'package:moviepedia/domain/entities/movie.dart';

// ESTE ES EL ORIGEN DE DATOS
abstract class MovieDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
