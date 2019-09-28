import 'package:bloc/bloc.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/api_models.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/player_listing_events.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/player_listing_states.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/player_repository.dart';

class PlayerListingBloc extends Bloc<PlayerListingEvent, PlayerListingState> {
  PlayerRepository playerRepository;

  PlayerListingBloc({this.playerRepository}) : assert(playerRepository != null);

  @override
  PlayerListingState get initialState => PlayerUninitialisedState();

  @override
  Stream<PlayerListingState> mapEventToState(PlayerListingEvent event) async* {
    yield PlayerFetchingState();
    if (event is CountrySelectedEvent) {
      try {
        List<Players> players = await playerRepository
            .fetchPlayersByCountry(event.nationModel.countryId);

        if (players.length == 0) {
          yield PlayerEmptyState();
        } else {
          yield PlayerFetchedState(players: players);
        }
      } catch (error) {
        print("Error final : ${error.toString()}");
        yield PlayerErrorState();
      }
    }
  }
}
