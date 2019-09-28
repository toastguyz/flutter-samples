import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/api_models.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/player_api_provider.dart';

class PlayerRepository{
  PlayerApiProvider _playerApiProvider=PlayerApiProvider();

  Future<List<Players>> fetchPlayersByCountry(String countryID)=>_playerApiProvider.fetchPlayersByCountry(countryID);

  Future<List<Players>> fetchPlayersByName(String name)=>_playerApiProvider.fetchPlayersByName(name);
}