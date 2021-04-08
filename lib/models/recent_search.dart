import 'package:yugioh_rest_api/database_strings.dart';

class RecentSearch{
  int id;
  String searchName;

  RecentSearch({this.id, this.searchName});

  RecentSearch.fromMapToObject(Map<String, dynamic> map){
    this.id = map[DatabaseStrings.colId];
    this.searchName = map[DatabaseStrings.colRecentSearch];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {};
    map[DatabaseStrings.colId] = this.id;
    map[DatabaseStrings.colRecentSearch] = this.searchName;
    return map;
  }
}