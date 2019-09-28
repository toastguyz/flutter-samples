import 'dart:convert';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/api_models.dart';
import 'package:http/http.dart' as http;

class PlayerApiProvider {
  String baseURL = "https://www.easports.com/fifa/ultimate-team/api/fut/item?";

  final API_SUCCESS_CODE=200;

  Future<List<Players>> fetchPlayersByCountry(String countryID) async {
    print("call URL : ${baseURL}country=${countryID}");
    final response = await http.get("${baseURL}country=${countryID}");

    var responseData = jsonDecode(response.body);
    if(response.statusCode==API_SUCCESS_CODE){
      return ApiResult.fromJson(responseData).items;
    }else{
      print("Error : ${response.statusCode}");
      print("ErrorData : ${response.body}");
      throw Exception("Failed to load players.");
    }
  }

  Future<List<Players>> fetchPlayersByName(String name) async {
    print("call URL : ${baseURL}name=${name}");
    final response = await http.get("${baseURL}name=${name}");

    var responseData = jsonDecode(response.body);
    if(response.statusCode==API_SUCCESS_CODE){
      return ApiResult.fromJson(responseData).items;
    }else{
      print("Error : ${response.statusCode}");
      print("ErrorData : ${response.body}");
      throw Exception("Failed to load players.");
    }
  }
}
