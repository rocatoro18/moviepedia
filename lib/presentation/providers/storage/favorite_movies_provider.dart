import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/domain/repositories/local_storage_repository.dart';
import 'package:moviepedia/presentation/providers/storage/local_storage_provider.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  // MANDAMOS A LLAMAR LA INSTANCIA DE STORAGEMOVIENOTIFIER
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

/*
  MAPA DE PELICULAS
{
  12345: Movie,
  32434: Movie,
  23423: Movie
} 
*/

// CREAMOS UN NUEVO CONTENEDOR EN MEMORIA PARA TODAS LAS PELICULAS QUE VAN A ESTAR EN MEMORIA
// PARA TODAS LAS PELICULAS QUE VAN A ESTAR EN FAVORITOS Y DESPUES MOSTRARLOS
// EN PANTALLA

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  // REPOSITORIO QUE VA A LLAMAR AL DATASOURCE, ESTO SIRVE PARA LOS
  // CASOS DE USO QUE TIENE EL REPOSITORIO
  final LocalStorageRepository localStorageRepository;
  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<void> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
        offset: page * 10); // TODO: LIMIT 20
    page++;

    // CONVERSION DE LISTADO A MAPA
    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      // ESTUDIAR ESTO
      tempMoviesMap[movie.id] = movie;
    }

    // SPREAD DEL ESTADO ANTERIOR PARA NOTIFICAR QUE HUBO UN CAMBIO EN EL ESTADO
    state = {...state, ...tempMoviesMap};

    //return movies;
  }
}
