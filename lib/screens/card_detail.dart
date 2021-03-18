import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:yugioh_rest_api/models/yugioh_card.dart';

class CardDetail extends StatefulWidget {
  final int cardId;
  CardDetail({@required this.cardId});

  @override
  _CardDetailState createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  bool isLoading = true;
  YuGiOhCard card = YuGiOhCard();

  void downloadData() async {
    String url = env['CARD_INFO'] + 'id=${widget.cardId}';
    Response response = await get(url);
    Map map = jsonDecode(response.body);
    List cards = map['data'];
    print(cards);
    for (int i = 0; i < cards.length; i++) {
      card.id = cards[i]['id'];
      card.name = cards[i]['name'];
      card.desc = cards[i]['desc'];
      card.type = cards[i]['type'];
      card.race = cards[i]['race'];
      card.image = cards[i]['card_images'][0]['image_url'];
      card.imageSmall = cards[i]['card_images'][0]['image_url_small'];
      card.archetype = cards[i]['archetype'];
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
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: isLoading
          ? Center(
              child: SpinKitFadingCircle(
                size: 70,
                color: Colors.greenAccent,
              ),
            )
          : SafeArea(
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  CachedNetworkImage(
                    imageUrl: card.image,
                    placeholder: (BuildContext context, String path) =>
                        Image.asset('images/card_back.png'),
                    errorWidget:
                        (BuildContext context, String path, dynamic d) =>
                            Image.asset('images/card_back.png'),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type: ${card.type}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Race: ${card.race}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        card.archetype != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    'Arechetype: ${card.archetype}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 5,
                      ),
                    ),
                    child: Text(
                      card.desc,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
