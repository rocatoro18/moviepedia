import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                      final movieRepository = ref.read(movieRepositoryProvider);
                      showSearch(
                          // MANDAMOS LA REFERENCIA A LA FUNCION SIN EJECUTAR
                          context: context,
                          delegate: SearchMovieDelegate(
                              searchMovies: movieRepository.searchMovies));
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }
}
