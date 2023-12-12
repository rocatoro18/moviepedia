// PROVEER EL REPOSITORIO

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:moviepedia/infrastructure/repositories/movie_repository_impl.dart';

// ESTE REPOSITORIO ES INMUTABLE
// ESTE PROVIDER ES DE SOLO LECTURA
// EL OBJETIVO DE ESTE ES PROPORCIONAR A LOS DEMAS
// PROVIDERS LA INFORMACION NECESARIA PARA QUE PUEDAN
// CONSULTAR LA INFORMACION DE ESTE REPOSITORY IMPLEMENTATION
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDbDatasource());
});
