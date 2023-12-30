import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/infrastructure/datasources/isar_datasource.dart';
import 'package:moviepedia/infrastructure/repositories/local_storage_repository_impl.dart';

// ESTO ME VA A PERMITIR TENER UN PROVIDER DE RIVERPOD DONDE ESTA CREADA LA INSTANCIA
// DE LocalStorageRepositoryImpl(IsarDatasource());
// EL CUAL VA A TENER TODOS LO METODOS QUE NECESITAMOS PARA
// LLEGAR AL REPOSITORIO
final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
