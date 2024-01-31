import 'package:miscelaneos/infrastructure/infrastructure.dart';

import '../../domain/domain.dart';

class PokemonMapper {

  static Pokemon pokeApiPokemonToEntity(Map<String ,dynamic>json){
    final pokeApiPokemon = PokeApiPokemonResponse.fromJson(json);

    return Pokemon(
      id: pokeApiPokemon.id,
      name: pokeApiPokemon.name,
      spriteFront: pokeApiPokemon.sprites.frontDefault,
    );
  }
}
