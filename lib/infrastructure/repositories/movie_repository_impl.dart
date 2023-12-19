// LLAMAR DATASOURCE Y EL DATASOURCE LLAMA ESOS METODOS
import 'package:moviepedia/domain/datasources/movies_datasource.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  // LLAMAMOS LA CLASE PADRE DEL DATASOURCE
  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  // MANDAR A LLAMAR EL DATASOURCE PARA QUE ESTE LLAME EL
  // GETNOW PLAYING
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    // RETORNAMOS LA IMPLEMENTACION DE ESE DATASOURCE
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }
}
