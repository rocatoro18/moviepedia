// PROVIDER UNICAMENTE DE LECTURA
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/presentation/providers/movies/movies_providers.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  // AQUI YA TENGO LAS PELICULAS QUE SE ESTAN REPRODUCIENDO
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.sublist(0, 6);
});
