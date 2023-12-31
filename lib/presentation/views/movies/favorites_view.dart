import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moviepedia/presentation/providers/providers.dart';

// init
// solo las primeras 10

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // ESTE ES EL PUENTE, ESTE READ DEL PROVIDER VA A MANDAR LLAMAR LA SIGUIENTE PAGINA
    //ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    // ESTE loadNextPage() es lo mismo que el ref.read de arriba
    // SE HACE PARA CENTALIZAR LA PETICION EN UN UNICO LUGAR
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // OBTENER EL MAPA DE FAVORITE MOVIES
    final favoriteMoviesMap = ref.watch(favoriteMoviesProvider);

    // CONVERTIR EL MAPA DE FAVORITE MOVIES A LIST
    final favoriteMoviesList = favoriteMoviesMap.values.toList();

    if (favoriteMoviesList.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline_sharp,
            size: 60,
            color: colors.primary,
          ),
          Text(
            'Ohhh noo!',
            style: TextStyle(fontSize: 30, color: colors.primary),
          ),
          const Text(
            'No tienes peliculas favoritas',
            style: TextStyle(fontSize: 20, color: Colors.black45),
          ),
          const SizedBox(height: 20),
          FilledButton.tonal(
              onPressed: () => context.go('/home/0'),
              child: const Text('Empieza a buscar'))
        ],
      ));
    }

    return Scaffold(
      body:
          MovieMasonry(loadNextPage: loadNextPage, movies: favoriteMoviesList),
    );
  }
}
