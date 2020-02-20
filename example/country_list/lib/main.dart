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
  List<String> suggestions;
  final Function onSelected;
  final Border border;
  final Function filter;
  final bool hideSuggestionsOnCreate;
  final double tileMinHeight;
  final double tileMaxHeight;

  SimpleAutocompleteSearch({
    this.hint,
    this.suggestions,
    this.onSelected,
    this.border,
    this.filter,
    this.hideSuggestionsOnCreate,
    this.tileMinHeight,
    this.tileMaxHeight,
  }) : super();

  @override
  _SimpleAutocompleteSearchState createState() =>
      _SimpleAutocompleteSearchState();
}

class _SimpleAutocompleteSearchState extends State<SimpleAutocompleteSearch> {
  List<String> _tmpSuggestions = []; // Will be shown to user

  double _suggestionsHeight = 1;
  String _fieldText = "";

  @override
  void initState() {
    if (widget.suggestions == null) {
      widget.suggestions = [
        "No suggestion list entered",
        "Pass List of strings to value of \'suggestions\' key",
        "suggestions: List<String>",
        "Foo",
        "Bar",
        "Abc",
        "abcdefghijklmnopqrstuvwxyzåäö",
        "ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ",
        "I am very long string. If you do not want the user to see the whole long text, You must use tileMaxHeight property. Normally tileMaxHeight is double.infinity. You can customize it. If you want it to be 200 just use tileMaxHeight:200. If you want to make sure everything fits, you could use double.infinity. Min height is also customizable, default value is 50. Happy codin' fo you!",
        "abcdefghijklmnopqrstuvwxyzåäö"
      ];
    }

    _textChanged(_fieldText);

    if (widget.hideSuggestionsOnCreate == null ||
        widget.hideSuggestionsOnCreate == true) {
      _suggestionsHeight = 1.0;
    }

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
                          minHeight: widget.tileMinHeight ?? 50,
                          maxHeight: widget.tileMaxHeight ?? double.infinity,
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
    for (String suggestion in widget.suggestions) {
      if (widget.filter == null) {
        // Go with the default filtering
        if (_isValid(suggestion, text)) {
          _tmpSuggestions.add(suggestion);
        }
      } else {
        // Use custom filtering
        if (widget.filter(suggestion, text)) {
          _tmpSuggestions.add(suggestion);
        }
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
    return suggestion.toLowerCase().contains(characters.toLowerCase());
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
