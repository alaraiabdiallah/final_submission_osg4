

import 'dart:convert';

import 'package:final_osg4/model.dart';
import 'package:http/http.dart' as http;

class CardRepository{

  Future<List<Cards>> getCards() async{
    final response = await http.get("https://db.ygoprodeck.com/api/v5/cardinfo.php");

    if(response.statusCode == 200){
      var result = json.decode(response.body);
      return (result as List).map((data) => Cards.fromJson(data)).toList();
    }else{
      throw Exception("Cannot load cards");
    }
  }

}