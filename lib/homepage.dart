import 'dart:convert';

import 'package:covid_tracker_app/datasorce.dart';
import 'package:covid_tracker_app/pages/country_page.dart';
import 'package:covid_tracker_app/panels/infoPanel.dart';
import 'package:covid_tracker_app/panels/mostaffectedcountries.dart';
import 'package:covid_tracker_app/panels/worldwidepanel.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchWorldWideData();
    fetchCountryData();
  }

  Map worldData;
  fetchWorldWideData() async {
    String url = 'https://corona.lmao.ninja/v3/covid-19/all';
    final response = await http.get(Uri.parse(url));
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    String url = 'https://corona.lmao.ninja/v3/covid-19/countries?sort=cases';
    final response = await http.get(Uri.parse(url));
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        brightness: Brightness.dark,
           
        title: Text(
          "COVID-19 TRACKER",
          textAlign: TextAlign.start,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.orange[100],
              alignment: Alignment.center,
              height: 100,
              padding: EdgeInsets.all(10),
              child: Text(
                DataSource.quote,
                style: TextStyle(
                  color: Colors.orange[800],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Worldwide",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountryPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: primaryBlack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Regional",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            worldData == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : WorldWidePanel(worldData: worldData),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Most Affected Countries",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            countryData == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : MostAffetecCountries(countryData: countryData),
            SizedBox(height: 16),
            InfoPanel(),
            SizedBox(height: 20),
            Center(
              child: Text(
                "WE ARE TOGETHER IN THE FIGHT",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
