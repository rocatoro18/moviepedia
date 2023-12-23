import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/presentation/providers/providers.dart';

// MovieMapNotifier es nuestro NOTIFIER
// movieInfoProvider es nuestro PROVIDER

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final fetchMovieInfo = ref.watch(movieRepositoryProvider).getMovieById;
  // REGRESAMOS UNA NUEVA INSTANCIA DEL MOVIE MAP NOTIFIER
  return MovieMapNotifier(getMovie: fetchMovieInfo);
});

/* 
  Como va a lucir el StateNotifier ES NUESTRO state
  {
    '505642': Movie(),
    '505643': Movie(),
    '505644': Movie(),
    '505645': Movie(),
  }
*/

// ESPERAR FUNCION QUE REGRESE ALGO (ESTO SOLO ES LA DEFINICION)
typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  // LO INICIALIZAMOS COMO UN MAPA VACIO
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final movie = await getMovie(movieId);

    // HACER EL SPREAD PARA GENERAR UN NUEVO ESTADO
    state = {...state, movieId: movie};
  }
}
