import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yugioh_rest_api/models/yugioh_card.dart';

class CardDetail extends StatelessWidget {
  final YuGiOhCard card;
  CardDetail(this.card);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: !kIsWeb
          ? ListView(
              padding: EdgeInsets.all(8),
              children: [
                CachedNetworkImage(
                  imageUrl: card.image,
                  placeholder: (BuildContext context, String path) =>
                      Image.asset('images/card_back.png'),
                  errorWidget: (BuildContext context, String path, dynamic d) =>
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
                      card.archetype != null
                          ? Text(
                              'Arechetype: ${card.archetype}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
            )
          : Container(
              child: Text(
                'Hello',
                style: TextStyle(fontSize: 50),
              ),
            ),
    );
  }
}
