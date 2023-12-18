import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/presentation/providers/movies/movie_repository_provider.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // SOLO TOMAR LA REFERENCIA A LA FUNCION
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  // MANDAMOS NUEVO CASO DE USO
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // SOLO TOMAR LA REFERENCIA A LA FUNCION
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  // MANDAMOS NUEVO CASO DE USO
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

// DEFINIR EL TIPO DE CALLBACK QUE ESPERO
typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  // UTILIZADO PARA NO CARGAR PAGINAS DE MAS
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    //print('loading more movies');
    // HACER MODIFICACION AL STATE
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    // REGRESAR UN NUEVO ESTADO
    // CUANDO EL ESTADO CAMBIA RIVERPOD NOTIFICA
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
