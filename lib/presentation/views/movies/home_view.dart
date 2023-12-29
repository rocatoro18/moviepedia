import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/presentation/providers/providers.dart';

import '../../providers/movies/movies_slideshow_provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    // ESTE ES EL PUENTE, ESTE READ DEL PROVIDER VA A MANDAR LLAMAR LA SIGUIENTE PAGINA
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    // RENDERIZAR DATA
    // ESTAR PENDIENTE DEL ESTADO CON EL WATCH
    // CUANDO YA TENEMOS DATA MOSTRAMOS LAS PELICULAS MEDIANTE EL WATCH
    // ref.watch = OBTENEMOS EL ESTADO DEL PROVIDER
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    //if (moviesSlideShow.isEmpty) return const CircularProgressIndicator();

    // CustomScrollView Utilizado cuando se quiera trabajar con Slivers
    //return const FullScreenLoader();

    // AGREGAR WIDGET VISIBILITY?
    return CustomScrollView(
      // SLIVER = WIDGET QUE TRABAJA DIRECTAMENTE CON EL SCROLL VIEW
      slivers: [
        const SliverAppBar(
          floating: true,
          //title: Text('Hola Mundo'),
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              //const CustomAppBar(),
              //if (moviesSlideShow.isEmpty) const CircularProgressIndicator(),
              //if (moviesSlideShow.isNotEmpty)
              MoviesSlideShow(movies: moviesSlideShow),
              MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: 'En cines',
                subTitle: 'Lunes 20',
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListview(
                movies: upcomingMovies,
                title: 'Proximamente',
                subTitle: 'En este mes',
                loadNextPage: () {
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListview(
                movies: popularMovies,
                title: 'Populares',
                //subTitle: 'Lunes 20',
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListview(
                movies: topRatedMovies,
                title: 'Mejores calificadas',
                subTitle: 'De todos los tiempos',
                loadNextPage: () {
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                },
              ),
              const SizedBox(height: 10)
              /*
          Expanded(
            child: ListView.builder(
                itemCount: nowPlayingMovies.length,
                itemBuilder: (context, index) {
                  final movie = nowPlayingMovies[index];
                  return ListTile(title: Text(movie.title));
                }),
          ),*/
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
