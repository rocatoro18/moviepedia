import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/presentation/providers/movies/movie_repository_provider.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // SOLO TOMAR LA REFERENCIA A LA FUNCION
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

// DEFINIR EL TIPO DE CALLBACK QUE ESPERO
typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    // HACER MODIFICACION AL STATE
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // REGRESAR UN NUEVO ESTADO
    // CUANDO EL ESTADO CAMBIA RIVERPOD NOTIFICA
    state = [...state, ...movies];
  }
}
