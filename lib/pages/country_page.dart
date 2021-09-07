import 'dart:convert';
import 'package:covid_tracker_app/pages/search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData = [];
  fetchCountryData() async {
    String url = 'https://corona.lmao.ninja/v3/covid-19/countries';
    final response = await http.get(Uri.parse(url));
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Country Stats"),
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: Search(countryData));
          }, icon: Icon(Icons.search)),
        ],
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: countryData == null ? 0 : countryData.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey[100],
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left:30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text(
                                countryData[index]['country'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Image.network(
                              countryData[index]['countryInfo']['flag'],
                              height: 50,
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "CONFIRMED: " +
                                    countryData[index]['cases'].toString(),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "ACTIVE: " +
                                    countryData[index]['active'].toString(),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "RECOVERED: " +
                                    countryData[index]['recovered'].toString(),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "DEATHS: " +
                                    countryData[index]['deaths'].toString(),
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
