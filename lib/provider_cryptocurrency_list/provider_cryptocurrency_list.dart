import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/provider_cryptocurrency_list/crypto_model.dart';
import 'package:flutter_samples/provider_cryptocurrency_list/crypto_provider.dart';
import 'package:provider/provider.dart';

class ProviderWithFutureBuilderApp extends StatefulWidget {
  @override
  _ProviderWithFutureBuilderAppState createState() =>
      _ProviderWithFutureBuilderAppState();
}

class _ProviderWithFutureBuilderAppState
    extends State<ProviderWithFutureBuilderApp>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  CryptoProvider cryptoProvider;
  Future<List<Cryptomodel>> cryptoList;

  @override
  void initState() {
    super.initState();

    cryptoProvider = Provider.of<CryptoProvider>(context, listen: false);
    cryptoList = cryptoProvider.fetchCryptoListAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : Container(),
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return FutureBuilder<List<Cryptomodel>>(
            future: cryptoList,
            builder: (BuildContext context, AsyncSnapshot<List<Cryptomodel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                print("ConnectionState.none");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                print("ConnectionState.waiting");
              }

              if (snapshot.connectionState == ConnectionState.active) {
                print("ConnectionState.active");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                print("ConnectionState.done");
              }

              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text(
                      "No Data Found!!",
                      style: TextStyle(fontSize: 25.0),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
//                                      color: Colors.blue,
                                        color: Colors.primaries[
                                            index % Colors.primaries.length],
                                        width: 30.0,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    width: 50.0,
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.data[index].name
                                          .toUpperCase()
                                          .substring(0, 1),
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(snapshot.data[index].name,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold)),
                                    Text("\$ ${snapshot.data[index].price}",
                                        style: TextStyle(fontSize: 12.0)),
                                    Text(
                                        "1 hour : ${snapshot.data[index].percentage_change}",
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.red)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: horizontalTitleAlignment,
        children: <Widget>[
          Text("CryptoCurrency App"),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Crypto Currency...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery,
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
