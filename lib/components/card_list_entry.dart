import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:yugioh_rest_api/models/yugioh_card.dart';
import 'package:yugioh_rest_api/screens/card_detail.dart';

class CardListEntry extends StatefulWidget {
  final YuGiOhCard card;
  CardListEntry({@required this.card});
  @override
  _CardListENtryState createState() => _CardListENtryState();
}

class _CardListENtryState extends State<CardListEntry> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetail(
              cardId: widget.card.id,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: GradientColors.teal,
          ),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: widget.card.imageSmall,
              placeholder: (BuildContext context, String path) =>
                  Image.asset('images/card_back.png'),
              errorWidget: (BuildContext context, String path, dynamic d) =>
                  Image.asset('images/card_back.png'),
            ),
            SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.card.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                Text(
                  widget.card.type,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
