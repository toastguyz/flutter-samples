import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_samples/provider_cryptocurrency_list/crypto_model.dart';
import 'package:http/http.dart' as http;

enum APILoadingState { none, loading, error }

class CryptoProvider extends ChangeNotifier {
  static const cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";

  List<Cryptomodel> _cryptoList = [];

  List<Cryptomodel> get cryptoList => _cryptoList;

  /*Future<void> fetchCryptoListAsync() async {
    print("Inside API Call ");
    _changeLoadingState(APILoadingState.loading);

    final response = await http.get(cryptoUrl);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      print("received Data : ${data}");
      print("received Data : ${data.length}");
      print("received Data : ${data.runtimeType}");
      print("received Data : ${data[0]['id']}");
      print("received Data : ${data[0]['name']}");

//      for(var i = 0; i < data.length; i++){
//        print("received Data : ${data[i]['name']}");
//      }

      data.map((field) {
        _cryptoList.add(Cryptomodel.fromJson(field));
        print("received Data : ${field['name']}");
      }).toList();

      print("_cryptoList : ${_cryptoList}");
      print("_cryptoList : ${_cryptoList.length}");
    }
  }*/

  /*Future<List<Cryptomodel>> fetchCryptoListAsync() async {
    print("Inside API Call ");
    _changeLoadingState(APILoadingState.loading);

    final response = await http.get(cryptoUrl);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      _cryptoList=[];
      for (int i = 0; i < data.length; i++) {
        _cryptoList.add(Cryptomodel(
            id: data[i]["id"],
            name: data[i]["name"],
            percentage_change: data[i]["percent_change_1h"],
            price: data[i]["price_usd"]));
      }

      print("_cryptoList : ${_cryptoList}");
      print("_cryptoList : ${_cryptoList.length}");
    } else {
      print("error : " + response.body);
    }


    print("_cryptoListFinal : ${_cryptoList.runtimeType}");
    _changeLoadingState(APILoadingState.none);
    return _cryptoList;
  }*/

  Future<List<Cryptomodel>> fetchCryptoListAsync() async {
    print("Inside API Call ");

    final response = await http.get(cryptoUrl);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      _cryptoList=[];
      for (int i = 0; i < data.length; i++) {
        _cryptoList.add(Cryptomodel(
            id: data[i]["id"],
            name: data[i]["name"],
            percentage_change: data[i]["percent_change_1h"],
            price: data[i]["price_usd"]));
      }

      /*print("_cryptoList : ${_cryptoList}");
      print("_cryptoList : ${_cryptoList.length}");*/
    } else {
      /*print("error : " + response.body);*/
    }

    /*print("_cryptoListFinal : ${_cryptoList.runtimeType}");*/
    return _cryptoList;
  }
}
