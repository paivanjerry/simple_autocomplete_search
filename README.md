# simple_autocomplete_search

Really simple and easy to use autocomplete field with suggestions. You can customise what happens when item is selected and how filtering is done. Hint text and borders of the widget are also customizable.

## Getting Started

To get plugin up and running, add this to your pubspec.yaml
```
dependencies:
  simple_autocomplete_search: ^1.0.0
```
then get dependencies. In command line you can use
```
$ flutter pub get
```
and last step is to import in your dart file by adding following line

```
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
```


## Usage

Autocomplete works only with list of strings.

All parameters are optional, making possible that you can test the package by just importing and using:
```
SimpleAutocompleteSearch()
```
Following gif represents the bare minimum app with SimpleAutocompleteSearch.
<img src="https://github.com/paivanjerry/simple_autocomplete_search/master/demo_bare_minimum.gif">
To use it with your list and onPressed function:

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
    onSelected: myFunction,
    suggestions: myList
    filter: myFilteringFunction
    hint: myString
    border: myBorderWidget);
```
Filtering function must be in format:
```
void myFiltering function(String wholeSuggestion, String typedCharacters)
```

