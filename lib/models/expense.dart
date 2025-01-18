import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
DateFormat dateFormat = DateFormat.yMd();
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

enum Category {
  food,travel,leisure,work
}
class Expense {
  final String uid;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
    {required this.title, 
    required this.amount,
    required this.date,
    required this.category}) : uid = uuid.v4();

    String get formattedDate {
      return dateFormat.format(date);
    }
}