import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/presentation/delegates/search_movie_delegate.dart';
import 'package:moviepedia/presentation/providers/providers.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(Icons.movie_outlined, color: colors.primary),
                const SizedBox(width: 5),
                Text('Moviepedia', style: titleStyle),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      // DELEGATE = ENCARGADO DE MANEJAR LA BUSQUEDA
                      // TODO
                      final searchedMovies = ref.read(searchedMoviesProvider);
                      final searchQuery = ref.read(searchQueryProvider);
                      showSearch<Movie?>(
                              query: searchQuery,
                              // MANDAMOS LA REFERENCIA A LA FUNCION SIN EJECUTAR
                              context: context,
                              delegate: SearchMovieDelegate(
                                  initialMovies: searchedMovies,
                                  searchMovies: ref
                                      .read(searchedMoviesProvider.notifier)
                                      .searchMoviesByQuery
                                  /*(query) {
                            // GUARDAR EL QUERY EN EL STATE Y LUEGO LLAMAR AL REPOSITORIO
                            ref
                                .read(searchQueryProvider.notifier)
                                .update((state) => query);
                            return movieRepository.searchMovies(query);
                          }*/
                                  ))
                          .then((movie) {
                        // NAVEGAR A LA PELICULA SI ES QUE EXISTE
                        if (movie != null) {
                          context.push('/home/0/movie/${movie.id}');
                        }
                      });
                      //print(movie?.title);
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }
}
