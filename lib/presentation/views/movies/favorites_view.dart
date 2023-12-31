import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/presentation/providers/providers.dart';

// init
// solo las primeras 10

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    // ESTE ES EL PUENTE, ESTE READ DEL PROVIDER VA A MANDAR LLAMAR LA SIGUIENTE PAGINA
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // OBTENER EL MAPA DE FAVORITE MOVIES
    final favoriteMoviesMap = ref.watch(favoriteMoviesProvider);

    // CONVERTIR EL MAPA DE FAVORITE MOVIES A LIST
    final favoriteMoviesList = favoriteMoviesMap.values.toList();

    return Scaffold(
      body: MovieMasonry(movies: favoriteMoviesList),
    );
  }
}
