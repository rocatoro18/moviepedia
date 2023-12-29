import 'package:flutter/material.dart';
import 'package:moviepedia/presentation/views/movies/favorites_view.dart';
import 'package:moviepedia/presentation/views/movies/home_view.dart';
import 'package:moviepedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.pageIndex});

  static const name = 'home-screen';
  final int pageIndex;

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(), // CATEGORIAS
    FavoritesView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // WIDGET PARA PRESERVAR EL ESTADO IndexedStack
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      //bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}
