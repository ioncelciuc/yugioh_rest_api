import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:yugioh_rest_api/models/yugioh_card.dart';

class LoadData extends StatefulWidget {
  static const String id = 'LoadData';
  @override
  _LoadDataState createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData> {

  void downloadData() async{
    Response response = await get('https://db.ygoprodeck.com/api/v7/cardinfo.php');
    Map map = jsonDecode(response.body);
    List cards = map['data'];
    
    for(int i = 0; i<cards.length; i++){
      YuGiOhCard card = YuGiOhCard();
      card.id = cards[i]['id'];
      card.name = cards[i]['name'];
      
      print('${card.id} ${card.name}');
    }
  }

  @override
  void initState() {
    super.initState();
    downloadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}