import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quotes_api_demo/Models/QuotesModel.dart';

class HomeController {
  static int _nextId = 1;

  static Future<List<QuotesModel>> getQuotes() async {
    final response = await http.get(Uri.parse('https://type.fit/api/quotes'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((json) => QuotesModel(id: _nextId++,text: json['text'], author: json['author']))
          .toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }

  static Future<String> fetchRandomQuote({bool getNext = true}) async {
    final response = await http.get(Uri.parse('https://type.fit/api/quotes'));

    if (response.statusCode == 200) {
      final List<dynamic> quotes = json.decode(response.body);

      // Calculate the next or previous index
      int currentIndex = DateTime.now().microsecondsSinceEpoch % quotes.length;
      int newIndex = getNext ? (currentIndex + 1) % quotes.length : (currentIndex - 1) % quotes.length;

      // Handle edge cases
      if (newIndex < 0) {
        newIndex = quotes.length - 1;
      }

      final randomQuote = quotes[newIndex]['text'];
      return randomQuote;
    } else {
      throw Exception('Failed to load random quote');
    }
  }


}