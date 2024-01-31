import 'package:miscelaneos/domain/domain.dart';

abstract class PokemonsRepository {
  Future<(Pokemon?,String)> getPokemons(String id);
}