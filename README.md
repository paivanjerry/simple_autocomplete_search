# simple_autocomplete_search

Simple autocomplete field with suggestions.

## Getting Started


## Usage

Autocomplete works only with list of strings.

You can test the package by importing and using simply:
`SimpleAutocompleteSearch()`

To use it with your list and onPressed function:

`
List<String> myList = ["foo", "bar"];
void myFunction(String text){
    print(text);
}
SimpleAutocompleteSearch(onSelected: myFunction, suggestions: myList)`

