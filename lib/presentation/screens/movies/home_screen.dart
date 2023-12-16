import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/presentation/providers/movies/movies_providers.dart';
import 'package:moviepedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _HomeView());
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

    if (nowPlayingMovies.length == 0) return const CircularProgressIndicator();

    return Column(
      children: [
        CustomAppBar(),
        Expanded(
          child: ListView.builder(
              itemCount: nowPlayingMovies.length,
              itemBuilder: (context, index) {
                final movie = nowPlayingMovies[index];
                return ListTile(title: Text(movie.title));
              }),
        ),
      ],
    );
  }
}
