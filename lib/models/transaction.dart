import 'package:flutter/material.dart';

class Transaction {
  int id;
  String title;
  double price;
  DateTime date;
  String note;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.date,
    this.note,
  });
}
