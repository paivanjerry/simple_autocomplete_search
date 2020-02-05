import 'package:flutter/material.dart';
import 'package:simple_autocomplete_search/simple_autocomplete_search.dart';

void main() {
  runApp(MaterialApp(
    title: 'Autocomplete demo',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Demo autocomplete'),
        ),
        body: SimpleAutocompleteSearch());
  }
}
