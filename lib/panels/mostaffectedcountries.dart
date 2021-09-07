import 'package:flutter/material.dart';

class MostAffetecCountries extends StatelessWidget {
  final List countryData;
  MostAffetecCountries({this.countryData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Row(
              children: [
                Image.network(
                  countryData[index]['countryInfo']['flag'],
                  height: 25,
                ),
                SizedBox(width: 10),
                Text(
                  countryData[index]['country'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "Deaths " + countryData[index]['deaths'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
