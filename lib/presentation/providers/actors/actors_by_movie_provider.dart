import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/domain/entities/actor.dart';
import 'package:moviepedia/presentation/providers/actors/actors_repository_provider.dart';

// MovieMapNotifier es nuestro NOTIFIER
// movieInfoProvider es nuestro PROVIDER

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider).getActorsByMovie;
  // REGRESAMOS UNA NUEVA INSTANCIA DEL MOVIE MAP NOTIFIER
  return ActorsByMovieNotifier(getActors: actorsRepository);
});

/* 
  Como va a lucir el StateNotifier ES NUESTRO state
  {
    '505642': <Actor>[],
    '505643': <Actor>[],
    '505644': <Actor>[],
    '505645': <Actor>[],
  }
*/

// ESPERAR FUNCION QUE REGRESE ALGO (ESTO SOLO ES LA DEFINICION)
typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

// PAR DE VALOR LISTA DE ACTORES
class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  // LO INICIALIZAMOS COMO UN MAPA VACIO
  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    final List<Actor> actors = await getActors(movieId);

    // HACER EL SPREAD PARA GENERAR UN NUEVO ESTADO
    state = {...state, movieId: actors};
  }
}
