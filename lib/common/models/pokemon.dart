import 'package:flutter/material.dart';

class Pokemon {
  final String name;
  final List<String> type;
  //final List<String> previous;
 // final List<Pokemon> post;
  final List<String> weakness;
  final int id;
  final String num;
  final String height;
  final String weight;
  final String candy;
  final String rarity;
  final String pTipo;
  final String pNome;

  factory Pokemon.fromMap(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      num: json['num'],
      height: json['height'].toString(),
      weight: json['weight'].toString(),
      candy: json['candy'].toString(),
      rarity: json['spawn_chance'].toString(),
      type: (json['type'] as List<dynamic>)
          .map(
            (e) => e as String,
          )
          .toList(),
      weakness: (json['weaknesses'] as List<dynamic>)
          .map(
            (e) => e as String,
      )
          .toList(),
      /*post: (json['next-evolution'] as List<dynamic>)
          .map(
            (e) => e as Pokemon,
      )
          .toList(),*/
      pNome: (json['name'].toString().toLowerCase()),
      pTipo: (json['type'].toString().toLowerCase()),
    );
  }

  Color? get baseColor => _color(type: type[0]);
  String get image =>
      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png';
  Pokemon({
    required this.name,
    required this.type,
    required this.weakness,
    //required this.post,
    required this.id,
    required this.num,
    required this.height,
    required this.weight,
    required this.candy,
    required this.rarity,
    required this.pTipo,
    required this.pNome,
  });

  static Color? _color({required String type}) {
    switch (type) {
      case 'Normal':
        return Colors.brown[400];
      case 'Fire':
        return Colors.red;
      case 'Water':
        return Colors.blue;
      case 'Grass':
        return Colors.green;
      case 'Electric':
        return Colors.amber;
      case 'Ice':
        return Colors.cyanAccent[400];
      case 'Fighting':
        return Colors.orange;
      case 'Poison':
        return Colors.purple;
      case 'Ground':
        return Colors.orange[300];
      case 'Flying':
        return Colors.indigo[200];
      case 'Psychic':
        return Colors.pink;
      case 'Bug':
        return Colors.lightGreen[500];
      case 'Rock':
        return Colors.grey;
      case 'Ghost':
        return Colors.indigo[400];
      case 'Dark':
        return Colors.brown;
      case 'Dragon':
        return Colors.indigo[800];
      case 'Steel':
        return Colors.blueGrey;
      case 'Fairy':
        return Colors.pinkAccent[100];
      default:
        return Colors.grey;
    }
  }
}
