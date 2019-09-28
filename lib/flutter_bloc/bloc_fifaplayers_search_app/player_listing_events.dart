import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/nation_model.dart';
import 'package:meta/meta.dart';

abstract class PlayerListingEvent{}

class CountrySelectedEvent extends PlayerListingEvent{
  final NationModel nationModel;

  CountrySelectedEvent({@required this.nationModel}):assert(nationModel!=null);
}

class SearchTextChangedEvent extends PlayerListingEvent{
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm}):assert(searchTerm!=null);
}