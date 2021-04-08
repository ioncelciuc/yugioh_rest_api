import 'package:flutter/material.dart';
import 'package:yugioh_rest_api/components/card_list_entry.dart';
import 'package:yugioh_rest_api/models/yugioh_card.dart';

class CardList extends StatelessWidget {
  CardList({@required this.cardList});

  final List<YuGiOhCard> cardList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cardList.length,
      itemBuilder: (BuildContext context, int index) => CardListEntry(
        card: cardList[index],
      ),
    );
  }
}
