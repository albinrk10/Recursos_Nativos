import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';
import '../../../domain/domain.dart';
import '../../providers/providers.dart';

class PokemonScreen extends ConsumerWidget {
  final String pokemonId;

  const PokemonScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));
    return pokemonAsync.when(
        data: (pokemon) => _PokemonView(pokemon: pokemon),
        error: (error, stackTrace) => _ErrorWidget(message: error.toString()),
        loading: () => const _LoadingWidget());
  }
}

class _PokemonView extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonView({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pokemon.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {
                //Link = Deeplink
                SharedPlugin.sharedLink(
                  pokemon.spriteFront, 'Mira este pokemon'
                );
              },
            )
          ],
        ),
        body: Center(
          child: Image.network(
            pokemon.spriteFront,
            fit: BoxFit.contain,
            width: 150,
            height: 150,
          ),
        ));
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
    );
  }
}
