import 'package:flutter/material.dart';
import 'package:yugioh_rest_api/components/card_list.dart';
import 'package:yugioh_rest_api/models/recent_search.dart';
import 'package:yugioh_rest_api/models/yugioh_card.dart';
import 'package:yugioh_rest_api/services/database_helper.dart';

class CardSearchDelegate extends SearchDelegate<String> {
  final List<YuGiOhCard> cardList;
  CardSearchDelegate(this.cardList);

  List<RecentSearch> recentSearches = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_close,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != null && query != '') {
      RecentSearch recentSearch = RecentSearch(searchName: query);
      print('SEARCH: ${recentSearch.searchName}');
      DatabaseHelper.instance.insertRecentSearch(
        recentSearch,
      );
      List<YuGiOhCard> testList = cardList
          .where(
            (card) =>
                card.name.toLowerCase().contains(query.toLowerCase()) ||
                card.desc.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      print(testList.length);
      for (int index = 0; index < testList.length; index++)
        print(testList[index].name);

      return CardList(cardList: testList);
    }
    return ListView(children: []);
  }

  void getRecentSearches() async{
    recentSearches = await DatabaseHelper.instance.getRecentSearches();
    for(int i = 0; i < recentSearches.length; i++)
      print('${recentSearches[i].id} ${recentSearches[i].searchName}');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getRecentSearches();
    return ListView.builder(
      itemCount: recentSearches.length,
      itemBuilder: (context, index) => ListTile(
        onTap: (){
          query = recentSearches[index].searchName;
        },
        title: Text(recentSearches[index].searchName),
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }
}
