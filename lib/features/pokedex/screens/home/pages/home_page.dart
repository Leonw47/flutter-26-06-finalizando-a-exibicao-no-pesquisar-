import 'dart:html';

import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/pokedex/screens/details/container/detail_container.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/widgets/pokemon_item_widget.dart';
import 'package:pokedex/features/pokedex/screens/home/pages/pesquisa.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.list, required this.onItemTap})
      : super(key: key);
  final List<Pokemon> list;
  final Function(String, DetailArguments) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Pokedex',
            style: TextStyle(color: Colors.black, fontSize: 26),
          ),
        ),
        actions: [
          Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
             onPressed: () {
               showSearch(context: context, delegate: PesquisaPage(),);
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.separated(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return PokemonItemWidget(
              pokemon: list[index],
              onTap: onItemTap,
              index: index,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.transparent,
            );
          },
        ),
      ),
    );
  }
}
