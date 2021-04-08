import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:yugioh_rest_api/screens/load_data.dart';

class ArchetypesPage extends StatefulWidget {
  @override
  _ArchetypesPageState createState() => _ArchetypesPageState();
}

class _ArchetypesPageState extends State<ArchetypesPage>
    with AutomaticKeepAliveClientMixin {
  List<String> archetypeList = [];
  bool isLoading = true;

  @override
  bool get wantKeepAlive => true;

  void downloadData() async {
    Response response = await get(env['ARCH']);
    List archetypes = jsonDecode(response.body);

    for (int i = 0; i < archetypes.length; i++) {
      String archetype = archetypes[i]['archetype_name'];
      archetypeList.add(archetype);
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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: SpinKitFadingCircle(
                size: 70,
                color: Colors.greenAccent,
              ),
            )
          : ListView.builder(
              itemCount: archetypeList.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadData(
                        link: env['CARD_INFO'] +
                            'archetype=${archetypeList[index]}',
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: GradientColors.teal,
                    ),
                  ),
                  child: Text(
                    archetypeList[index],
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
    );
  }
}
