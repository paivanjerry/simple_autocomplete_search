/// This example app shows list of countries and reacts when user selects one.
/// It uses all of version 1.0.2 customizable features.

import 'package:flutter/material.dart';

import 'package:simple_autocomplete_search/simple_autocomplete_search.dart';

void main() {
  runApp(MaterialApp(
    title: 'Autocomplete full demo',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> countryList = [
    "United States",
    "Finland",
    "Germany",
    "Armenia",
    "Austria",
    "Spain",
    "London",
    "Italy",
    "Australia",
    "China",
    "Japan",
    "Argentina",
    "Armenia",
    "Albania"
  ];

  String _comment = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Full demo autocomplete'),
        ),
        body: Container(
          alignment: Alignment(
            0.0,
            -1.0,
          ),
          margin: new EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: new EdgeInsets.all(10),
                  child: Text(
                    "Choose a country you want to travel",
                    style: TextStyle(fontSize: 25, color: Color(0xFF000000)),
                  ),
                ),
                SimpleAutocompleteSearch(
                  hint: "Type country",
                  filter: myFiltering,
                  suggestions: countryList,
                  hideSuggestionsOnCreate: false,
                  tileMinHeight: 45,
                  tileMaxHeight: 200,
                  onSelected: handleCountySelection,
                  border: Border(
                    left: BorderSide(width: 3.0, color: Color(0xFFF2B140)),
                    right: BorderSide(width: 3.0, color: Color(0xFFF2B140)),
                    bottom: BorderSide(width: 3.0, color: Color(0xFFF2B140)),
                    top: BorderSide(width: 3.0, color: Color(0xFFF2B140)),
                  ),
                ),
                Text(_comment)
              ],
            ),
          ),
        ));
  }

  bool myFiltering(String suggestion, String typed) {
    // Hide the list when typed text is empty
    // Widgets default shows all suggestions when list is empty.

    if (typed == "") {
      return false;
    }

    // If you want the rest of the filtering to behave like default, use this
    /*
     return suggestion.toLowerCase().contains(typed.toLowerCase());
    */

    // Accept the suggestion if it starts with typed text.
    // Widget default filtering checks if suggestion contains typed text.
    return suggestion.toLowerCase().startsWith(typed.toLowerCase());
  }

  void handleCountySelection(String country) {
    switch (country) {
      case "Finland":
        {
          setState(() {
            _comment =
                "No you don't. It's freezing out there. It's not worth it."
                " Finland is now removed from the list";
            countryList.remove("Finland");
          });
        }
        break;

      case "London":
        {
          setState(() {
            _comment = "Wrong answer, that's a city.";
          });
        }
        break;

      default:
        {
          setState(() {
            _comment =
                "That's a good choice! I would also like to visit $country.";
          });
        }
        break;
    }
  }
}
