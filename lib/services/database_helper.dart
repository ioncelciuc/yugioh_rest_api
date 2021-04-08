import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yugioh_rest_api/database_strings.dart';
import 'package:yugioh_rest_api/models/recent_search.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE ${DatabaseStrings.tableSearches}'
      '('
      '${DatabaseStrings.colId} INTEGER PRIMARY KEY AUTOINCREMENT,'
      '${DatabaseStrings.colRecentSearch} TEXT'
      ')',
    );
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DatabaseStrings.databaseName);
    return await openDatabase(
      path,
      version: DatabaseStrings.databseVersion,
      onCreate: _onCreate,
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<List<Map<String, dynamic>>> _getAllRecentSearchesAsMaps() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM ${DatabaseStrings.tableSearches}');
  }

  Future<List<RecentSearch>> getRecentSearches() async {
    List<Map<String, dynamic>> recentSearchesMapList =
        await _getAllRecentSearchesAsMaps();
    List<RecentSearch> recentSearches = [];
    for (int i = 0; i < recentSearchesMapList.length; i++) {
      recentSearches
          .add(RecentSearch.fromMapToObject(recentSearchesMapList[i]));
    }
    if(recentSearches == null) return [];
    return recentSearches;
  }

  Future<int> insertRecentSearch(RecentSearch recentSearch) async {
    print('SEARCH: ${recentSearch.searchName}');
    Database db = await instance.database;
    return await db.insert(DatabaseStrings.tableSearches, recentSearch.toMap());
  }
}
