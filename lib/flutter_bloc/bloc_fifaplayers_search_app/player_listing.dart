import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/api_models.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/player_listing_bloc.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/player_listing_states.dart';
import 'package:flutter_samples/utils/project_utils.dart';

class PlayerListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<PlayerListingBloc>(context),
      builder: (BuildContext context, state) {
        if (state is PlayerUninitialisedState) {
          return Message(
              message: "Please select a country flag to fetch players.");
        } else if (state is PlayerEmptyState) {
          return Message(message: "No players found.");
        } else if (state is PlayerErrorState) {
          return Message(message: "Something went wrong!!");
        } else if (state is PlayerFetchingState) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final playerFetchedState = state as PlayerFetchedState;
          final players = playerFetchedState.players;
          return _buildPlayersList(players);
        }
      },
    );
  }

  Widget _buildPlayersList(List<Players> players) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            Players player = players[index];
            return ListTile(
              leading: Image.network(
                player.headshot.imgUrl,
                width: 70.0,
                height: 70.0,
              ),
              title: Text(
                player.name,
                style: titleStyle,
              ),
              subtitle: Text(player.club.name, style: subTitleStyle),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 8.0,
              color: Colors.transparent,
            );
          },
          itemCount: players.length),
    );
  }
}

class Message extends StatelessWidget {
  final String message;

  Message({this.message});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          message,
          style: messageStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
