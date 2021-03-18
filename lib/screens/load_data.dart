import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:yugioh_rest_api/components/card_list_entry.dart';
import 'package:yugioh_rest_api/models/yugioh_card.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoadData extends StatefulWidget {
  static const String id = 'LoadData';

  final String link;
  LoadData({@required this.link});
  @override
  _LoadDataState createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData>
    with AutomaticKeepAliveClientMixin {
  List<YuGiOhCard> cardList = [];
  bool isLoading = true;

  @override
  bool get wantKeepAlive => true;

  void downloadData() async {
    Response response = await get(widget.link);
    Map map = jsonDecode(response.body);
    List cards = map['data'];

    for (int i = 0; i < cards.length; i++) {
      YuGiOhCard card = YuGiOhCard();
      card.id = cards[i]['id'];
      card.name = cards[i]['name'];
      card.desc = cards[i]['desc'];
      card.type = cards[i]['type'];
      card.race = cards[i]['race'];
      card.image = cards[i]['card_images'][0]['image_url'];
      card.imageSmall = cards[i]['card_images'][0]['image_url_small'];
      card.archetype = cards[i]['archetype'];
      cardList.add(card);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    downloadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: isLoading
          ? Center(
              child: SpinKitFadingCircle(
                size: 70,
                color: Colors.greenAccent,
              ),
            )
          : ListView.builder(
              itemCount: cardList.length,
              itemBuilder: (BuildContext context, int index) => CardListEntry(
                card: cardList[index],
              ),
            ),
    );
  }
}
