import 'package:miscelaneos/infrastructure/infrastructure.dart';

import '../../domain/domain.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  final PokemonsDatasource dataSource;

  PokemonsRepositoryImpl({PokemonsDatasource? dataSource})
      : dataSource = dataSource ?? PokemonsDatasourceImpl();


  @override
  Future<(Pokemon?, String)> getPokemons(String id) async{
    
    return dataSource.getPokemons(id);

  }

  

}