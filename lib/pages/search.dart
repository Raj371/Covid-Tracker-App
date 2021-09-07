import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List countryList;
  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    // Widgets to display after the search query in the [AppBar].

    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // A widget to display before the current query in the [AppBar].
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Widget forms = query.isEmpty
        ? Center(
            child: Text(
            "No Match Found",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ))
        : null;

    if (forms != null) return forms;

    final List single = countryList
        .where((element) =>
            element['country'].toString().toLowerCase() == query.toLowerCase())
        .toList();

    if (single == null) {
      return Center(
          child: Text(
        "No Match Found",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ));
    } else {
      return ListView.builder(
          itemCount: single.length,
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
                    margin: EdgeInsets.only(left: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            single[index]['country'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Image.network(
                          single[index]['countryInfo']['flag'],
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
                            "CONFIRMED: " + single[index]['cases'].toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "ACTIVE: " + single[index]['active'].toString(),
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "RECOVERED: " +
                                single[index]['recovered'].toString(),
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "DEATHS: " + single[index]['deaths'].toString(),
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
          });
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) => element['country']
                .toString()
                .toLowerCase()
                .startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
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
                  margin: EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          suggestionList[index]['country'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Image.network(
                        suggestionList[index]['countryInfo']['flag'],
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
                              suggestionList[index]['cases'].toString(),
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "ACTIVE: " +
                              suggestionList[index]['active'].toString(),
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "RECOVERED: " +
                              suggestionList[index]['recovered'].toString(),
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "DEATHS: " +
                              suggestionList[index]['deaths'].toString(),
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
        });
  }
}
