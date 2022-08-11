extension StringExtension on String {
  /// convert input string to string with capital letter of each word format
  /// i.e  this is a test => This Is a Test
  String get toCapitalizeFirstofEach {
    final strictLowerCaseList = ["a", "an"];
    return split(" ").map((str) {
      return strictLowerCaseList.contains(str)
          ? str.toLowerCase()
          : str.toSentence;
    }).join(" ");
  }

  /// convert input string to sentence format
  /// i.e this is test => This is test
  String get toSentence => isEmpty
      ? ''
      : length == 1
          ? this[0].toLowerCase()
          : '${this[0].toUpperCase()}${substring(1)}';

  /// truncate string
  /// i.e. 'My Very Long Text'.truncateTo(7); => My Very...
  String truncate(int maxLength) =>
      (length <= maxLength) ? this : '${substring(0, maxLength)}...';

  /// i.e. helloWorld => hello_world
  String splitCamelCase(String join) {
    String result = "";
    final beforeNonLeadingCapitalLetter = RegExp(r"(?=(?!^)[A-Z])");
    List<String> splits = split(beforeNonLeadingCapitalLetter);
    for (var i = 0; i < splits.length; i++) {
      if (i != splits.length - 1) {
        result = result + splits[i].toLowerCase() + join;
      } else {
        result = result + splits[i].toLowerCase();
      }
    }
    return result;
  }

  
}

extension IndexedIterable<E> on Iterable<E> {
  /// returns map data with index
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
