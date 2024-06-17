// To parse this JSON data, do
//
//     final quotesModel = quotesModelFromJson(jsonString);

import 'dart:convert';

// List<QuotesModel> quotesModelFromJson(String str) => List<QuotesModel>.from(json.decode(str).map((x) => QuotesModel.fromJson(x)));

// String quotesModelToJson(List<QuotesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuotesModel {
  final int id;
  String text;
  String author;
  bool isFavorite;

  QuotesModel({
    required this.id,
    required this.text,
    required this.author,
    this.isFavorite = false,
  });
}
