import 'package:flutter/material.dart';

class PokemonScreen extends StatelessWidget {
  final String pokemonId;

  const PokemonScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon $pokemonId'),
      ),
      body: Center(
        child: Text('Pokemon $pokemonId'),
    ));
  }
}