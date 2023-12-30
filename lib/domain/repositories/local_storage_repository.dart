import 'package:moviepedia/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavorite(Movie movie);
  Future<bool> isMovieFavorite(int movidId);
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
