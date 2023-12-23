import 'package:moviepedia/domain/datasources/actors_datasource.dart';
import 'package:moviepedia/domain/entities/actor.dart';
import 'package:moviepedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  // CUALQUIER CLASE QUE EXTIENDA DE ACTORS DATASOURCE VA A SER PERMITIDA
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}
