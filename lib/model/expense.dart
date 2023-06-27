import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, transport, entertainment, education, home, others }

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.transport: Icons.directions_car,
  Category.entertainment: Icons.movie_filter,
  Category.education: Icons.book ,
  Category.home: Icons.home,
  Category.others: Icons.question_mark,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  
  String get formattedDate {
    return formatter.format(date);
  }
}
