import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:moviepedia/config/helpers/human_formats.dart';
import 'package:moviepedia/domain/entities/movie.dart';

// TIENE QUE HABER UNA FUNCION QUE CUMPLA ESTA FIRMA
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  // BROADCAST = SIRVE PARA TENER MULTIPLES LISTENERS
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  List<Movie> initialMovies;
  // TIMER ME PERMITE A MI DETERMINAR UN PERIODO DE TIEMPO Y TAMBIEN PERMITE LIMPIARLO Y CANCELARLO
  Timer? _debounceTimer;

  SearchMovieDelegate({required this.initialMovies, required this.searchMovies})
      : super(searchFieldLabel: 'Buscar peliculas');

  void clearStreams() {
    debouncedMovies.close();
  }

  void _onQueryChanged(String query) {
    //print('Query String cambio');
    // TAN PRONTO SE EMPIECE A ESCRIBIR SE CARGA VALORES AL isLoadingStream
    isLoadingStream.add(true);
    // SE ESTA LIMPIANDO CADA VEZ QUE LA PERSONA ESCRIBE ALGO SI ESTA ACTIVO LIMPIAR EL DEBOUNCE TIMER
    if (_debounceTimer?.isActive ?? false) {
      //isLoadingStream.add(false);
      _debounceTimer!.cancel();
    }
    // CUANDO SE DEJA DE ESCRIBIR POR 500 MILESIMAS SE EJECUTA EL CALLBACK
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      //TODO: Buscar peliculas y emitir al stream
      //print('Buscando peliculas');
      /*
      if (query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }
      */
      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      // SE DETIENE UNA VEZ QUE YA SE TIENEN LAS PELICULAS
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
        initialData: initialMovies,
        //future: searchMovies(query),
        //initialData: initialMovies,
        stream: debouncedMovies.stream,
        builder: (context, snapshot) {
          // NO USARfinal tempMovies = debouncedMovies.stream.last;
          //print('Realizando Petición');
          final movies = snapshot.data ?? [];

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return _MovieItem(
                    movie: movie,
                    onMovieSelected: (context, movie) {
                      clearStreams();
                      close(context, movie);
                    });
              });
        });
  }

  /*
  @override
  String get searchFieldLabel => 'Buscar película';
  */

  @override
  List<Widget>? buildActions(BuildContext context) {
    //print('query: $query');

    return [
      //if (query.isNotEmpty)
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;
          // print('snapshot data ${snapshot.data}');

          return isLoading
              ? SpinPerfect(
                  //animate: query.isNotEmpty,
                  duration: const Duration(seconds: 20),
                  spins: 10,
                  child: IconButton(
                      onPressed: () => query = '',
                      icon: const Icon(Icons.refresh)))
              : FadeIn(
                  animate: query.isNotEmpty,
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                      onPressed: () => query = '',
                      icon: const Icon(Icons.clear)));
        },
      ),

      /*
      FadeIn(
          animate: query.isNotEmpty,
          duration: const Duration(milliseconds: 200),
          child: IconButton(
              onPressed: () => query = '', icon: const Icon(Icons.clear))),
      */
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    //_onQueryChanged(query);
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // _onQueryChanged aplica nuestro debouncer
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: size.width * 0.20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(HumanFormats.number(movie.voteAverage, 1),
                          style: textStyles.bodyMedium!
                              .copyWith(color: Colors.yellow.shade900))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
