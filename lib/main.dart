import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/common/repositories/pokemon_repository.dart';
import 'package:pokedex/features/pokedex/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Pokedex',
              theme: ThemeData(
                useMaterial3: true,
                primarySwatch: Colors.red,
              ),
              home: PokedexRoute(
                repository: PokemonRepository(
                  dio: Dio(),
                ),
              ),
            );
  }
}