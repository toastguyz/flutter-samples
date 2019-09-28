import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/horizontal_bar.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/player_listing.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/player_listing_bloc.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/player_listing_events.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/player_repository.dart';
import 'package:flutter_samples/utils/project_utils.dart';

class FifaPlayerSearchApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FifaPlayerSearchAppState();
  }
}

class FifaPlayerSearchAppState extends State<FifaPlayerSearchApp> {
  PlayerRepository playerRepository = PlayerRepository();
  PlayerListingBloc playerListingBloc;

  @override
  void initState() {
    super.initState();
    playerListingBloc = PlayerListingBloc(playerRepository: playerRepository);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => playerListingBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Fifa Players",
            style: appBarStyle,
          ),
        ),
        body: Column(
          children: <Widget>[
            HorizontalBar(),
            SizedBox(
              height: 10.0,
            ),
            /*SearchBar(),
            SizedBox(
              height: 10.0,
            ),*/
            PlayerListing(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: TextField(
        style: titleStyle,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            border: InputBorder.none,
            hintText: "Search Players",
            hintStyle: hintSearchBarStyle,
            prefixIcon: Icon(
              Icons.person,
              size: 30.0,
              color: Colors.black,
            )),
        onChanged: (String searchTerm) {
          BlocProvider.of<PlayerListingBloc>(context)
              .dispatch(SearchTextChangedEvent(searchTerm: searchTerm));
        },
      ),
    );
  }
}
