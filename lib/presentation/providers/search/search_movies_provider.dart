import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/presentation/providers/providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return SearchedMoviesNotifier(
      searchMovies: movieRepository.searchMovies, ref: ref);
});

// DEFINIMOS LA FUNCION PERSONALIZADA
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

// CREAMOS EL NOTIFIER PARA SEARCHEDMOVIESPROVIDER
class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  // PROPORCIONAR REFERENCIA AL WIDGET REF
  final Ref ref;

  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
      : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    // (LLAMAR PROVIDER DENTRO DE OTRO PROVIDER) ENLAZAR EL SEARCHNOTIFIER CON EL SEARCHEDMOVIESNOTIFIER
    ref.read(searchQueryProvider.notifier).update((state) => query);
    // NO HAGO EL SPREAD PORQUE NO QUIERO MANTENER LAS PELICULAS ANTERIORES
    state = movies;
    return movies;
  }
}
