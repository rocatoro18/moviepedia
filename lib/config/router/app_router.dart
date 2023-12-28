import 'package:go_router/go_router.dart';
import 'package:moviepedia/presentation/screens/screens.dart';
import 'package:moviepedia/presentation/views/home_views/favorite_views.dart';
import 'package:moviepedia/presentation/views/views.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(
            childView: HomeView(),
          ),
      routes: [
        // RUTAS HIJAS
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final movieId = state.pathParameters['id'] ?? 'no-id';

              return MovieScreen(movieId: movieId);
            })
      ]),
]);
