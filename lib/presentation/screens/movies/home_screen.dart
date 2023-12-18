import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/presentation/providers/movies/movies_providers.dart';
import 'package:moviepedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:moviepedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    // ESTE ES EL PUENTE, ESTE READ DEL PROVIDER VA A MANDAR LLAMAR LA SIGUIENTE PAGINA
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // RENDERIZAR DATA
    // ESTAR PENDIENTE DEL ESTADO CON EL WATCH
    // CUANDO YA TENEMOS DATA MOSTRAMOS LAS PELICULAS MEDIANTE EL WATCH
    // ref.watch = OBTENEMOS EL ESTADO DEL PROVIDER
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);

    //if (moviesSlideShow.isEmpty) return const CircularProgressIndicator();

    // CustomScrollView Utilizado cuando se quiera trabajar con Slivers
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
                movies: nowPlayingMovies,
                title: 'Proximamente',
                subTitle: 'En este mes',
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: 'Populares',
                //subTitle: 'Lunes 20',
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: 'Mejores calificadas',
                subTitle: 'De todos los tiempos',
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
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
