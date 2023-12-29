import 'package:flutter/material.dart';
import 'package:moviepedia/presentation/views/movies/home_view.dart';
import 'package:moviepedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
