/// # Flutter SimpleAutocompleteSearch
///
/// Takes list as a parameter, shows suggestions when user types.
/// You can specify how suggestions are filtered (default: case-insensitive contains).
/// You can specify what happens when user clicks a suggestion.
/// Hint text and borders are also customizable.

library simple_autocomplete_search;

import 'package:flutter/material.dart';

class SimpleAutocompleteSearch extends StatefulWidget {
  final String hint;
  final List<String> suggestions;

  final Function onSelected;
  final Border border;
  final Function filter;

  SimpleAutocompleteSearch(
      {this.hint, this.suggestions, this.onSelected, this.border, this.filter})
      : super();

  @override
  _SimpleAutocompleteSearchState createState() =>
      _SimpleAutocompleteSearchState();
}

class _SimpleAutocompleteSearchState extends State<SimpleAutocompleteSearch> {
  List<String> _tmpSuggestions = []; // Will be shown to user
  List<String> _allSuggestions = []; // Keeps all suggestion strings
  double _suggestionsHeight = 1;
  String _fieldText = "";

  @override
  void initState() {
    if (widget.suggestions == null) {
      _allSuggestions = [
        "No suggestion list entered",
        "Foo",
        "Bar",
        "Abc",
        "abcdefghijklmnopqrstuvwxyzåäö",
        "ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ"
      ];
    } else {
      _allSuggestions = []..addAll(widget.suggestions);
    }

    _textChanged(_fieldText);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Focus(
            onFocusChange: _handleFocusChanged,
            child: TextField(
              onChanged: _textChanged,
              decoration: new InputDecoration(
                hintText: widget.hint ?? 'Insert text here',
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 1,
              maxHeight: _suggestionsHeight,
              maxWidth: double.infinity,
              minWidth: double.infinity,
            ),
            child: Container(
                decoration: BoxDecoration(
                    border: widget.border ??
                        Border(
                          left:
                              BorderSide(width: 1.0, color: Color(0xFFbfbfbf)),
                          right:
                              BorderSide(width: 1.0, color: Color(0xFFbfbfbf)),
                          bottom:
                              BorderSide(width: 1.0, color: Color(0xFFbfbfbf)),
                        )),
                child: Scrollbar(
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 50,
                          maxHeight: 100,
                          maxWidth: double.infinity,
                          minWidth: double.infinity,
                        ),
                        child: ListTile(
                          onTap: () {
                            _handleSuggestionPress(_tmpSuggestions[position]);
                          },
                          title: Text(_tmpSuggestions[position]),
                        ),
                      );
                    },
                    itemCount: _tmpSuggestions.length,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void _textChanged(String text) {
    _fieldText = text;

    _tmpSuggestions.clear();

    // Loop new list and add valid suggestions to original list.
    for (String suggestion in _allSuggestions) {
      if (_isValid(suggestion, text)) {
        _tmpSuggestions.add(suggestion);
      }
    }
    setState(() {});

    int suggestionsLength = _tmpSuggestions.length;
    if (suggestionsLength == 0) {
      _suggestionsHeight = 1;
      return;
    } else if (suggestionsLength > 4) {
      _suggestionsHeight = 250.0;
    } else {
      _suggestionsHeight = suggestionsLength.toDouble() * 60 + 10;
    }
  }

  bool _isValid(String suggestion, String characters) {
    if (suggestion.toLowerCase().contains(characters.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  void _handleFocusChanged(bool focus) {
    if (focus) {
      _textChanged(_fieldText);
    } else {
      setState(() {
        _suggestionsHeight = 1;
      });
    }
  }

  void _handleSuggestionPress(String selected) {
    if (widget.onSelected == null) {
      print(
          "SimpleAutocompleteSearch: No selected function to handle pressing the element " +
              "\"" +
              selected +
              "\"");
    } else {
      widget.onSelected(selected);
    }
  }
}
