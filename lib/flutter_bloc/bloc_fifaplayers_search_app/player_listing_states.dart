import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/api_models.dart';
import 'package:meta/meta.dart';

abstract class PlayerListingState {}

class PlayerUninitialisedState extends PlayerListingState {}

class PlayerFetchingState extends PlayerListingState {}

class PlayerFetchedState extends PlayerListingState {
  final List<Players> players;

  PlayerFetchedState({@required this.players}) : assert(players != null);
}

class PlayerErrorState extends PlayerListingState {}

class PlayerEmptyState extends PlayerListingState {}
