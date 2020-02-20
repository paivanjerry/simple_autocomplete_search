# simple_autocomplete_search

Really simple and easy to use autocomplete field with suggestions. You can customise what happens when item is selected and how filtering is done. Hint text and borders of the widget are also customizable.

## Getting Started

To get plugin up and running, add following to your pubspec.yaml. Check the latest version number from [here](https://pub.dev/packages/simple_autocomplete_search).
```
dependencies:
  simple_autocomplete_search: ^1.0.4
```
Then get the dependencies using the code editor or command line. In command line you can use
```
$ flutter pub get
```
and the last step is to import the package to your dart file by adding following line.

```
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
```
 ## Pub Package
 See the Pub Package and the latest released version [here](https://pub.dev/packages/simple_autocomplete_search).

## Usage

Autocomplete works only with a list of strings. It refreshes when it gains focus.

All parameters are optional, making possible that you can test the package by just importing and using:
```
SimpleAutocompleteSearch()
```
Following gif demonstrates the bare minimum app with SimpleAutocompleteSearch. The code can be found in [examples](https://github.com/paivanjerry/simple_autocomplete_search/blob/master/example/bare_minimum/lib/main.dart).

![Bare minimum demo](https://github.com/paivanjerry/simple_autocomplete_search/blob/master/demo_bare_minimum.gif)

The simplest search bar use will be following:
```
List<String> myList = ["foo", "bar"];
void myFunction(String text){
    print(text);
}
SimpleAutocompleteSearch(onSelected: myFunction, suggestions: myList);
```

SimpleAutocompleteSearch can take following parameters:
```
SimpleAutocompleteSearch(
    onSelected: Function(String),
    suggestions: List<String>,
    filter: Functions(String, String), // First string is suggestion, second is typed characters.
    hint: String,
    border: Border,
    tileMinHeight: double, // default: 50
    tileMaxHeight: double // default: infinity
    hideSuggestionsOnInit: bool // default: true
    )
```
Filtering function must be in format:
```
bool myFiltering function(String wholeSuggestion, String typedCharacters)
```
Following gif is from sample app providing all parameters to SimpleAutocompleteSearch

![Bare minimum demo](https://github.com/paivanjerry/simple_autocomplete_search/blob/master/demo_whole.gif)

See the [examples](https://github.com/paivanjerry/simple_autocomplete_search/blob/master/example) to find out more.