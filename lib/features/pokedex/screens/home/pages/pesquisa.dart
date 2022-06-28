import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/pokedex/screens/details/container/detail_container.dart';
import '../../details/pages/detail_page.dart';

class PesquisaPage extends SearchDelegate<String> {
  late final Dio dio;
  late final onBack;
  late final controller;
  late final onChangePokemon;
  late ScrollController scrollController;

  void initState() {
    onBack = VoidCallback ;
    controller = PageController;
    onChangePokemon = ValueChanged<Pokemon>;
    scrollController = ScrollController();
  }

  @override
  String get searchFieldLabel => 'Nome, Tipo ou Raridade';


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
      // TODO: implement buildResults
      return FutureBuilder<List<Pokemon>>(
        future: resultado(query),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            var n = int.parse(query) - 1;


            print(onBack);
            print(controller);
            print(onChangePokemon);
            return DetailPage(pokemon: snapshot.data![n], list: snapshot.data!, onBack: onBack, controller: controller, onChangePokemon: onChangePokemon);
          }else if(snapshot.hasError){
            print(snapshot.data);
            print(snapshot.error);
            return Center(child: Text('Erro ao escolher'),);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },);
    }



  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List<Pokemon>?>(
        future: sugestoes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int exibiu = 0;

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                if(snapshot.data![index].name.contains(query) ||
                    snapshot.data![index].pNome.contains(query) ||
                    snapshot.data![index].type.contains(query) ||
                    snapshot.data![index].pTipo.contains(query) ||
                    snapshot.data![index].rarity.contains(query)){

                  exibiu++;
                  return ListTile(
                    leading: Image.network(snapshot.data![index].image),
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].num),
                    onTap: (){
                      query = snapshot.data![index].id.toString();
                      showResults(context);
                    },
                  );
                }else{
                  if(exibiu == 0 && index == 150 ){
                    return Center(
                      child: Text('Não foi encontrado.'),
                    );
                  }
                  return Container();
                }
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao buscar'),
            );
          }
          return Center(child: CircularProgressIndicator(),
          );
        });
  }

  Future<List<Pokemon>> sugestoes() async {
    final Dio dio = Dio();
    final response = await dio.get('https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json?search=$query');
    final json = jsonDecode(response.data) as Map<String, dynamic>;
    final list = json['pokemon'] as List<dynamic>;

    return list.map((e) => Pokemon.fromMap(e)).toList();
  }


  Future<List<Pokemon>> resultado(String id) async{
    final Dio dio = Dio();
    final response = await dio.get('https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json?search=$query');
    final json = jsonDecode(response.data) as Map<String, dynamic>;
    final list = json['pokemon'] as List<dynamic>;

    return list.map((e) => Pokemon.fromMap(e)).toList();

  }
}
