import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Expense {
  final String expenseId;
  final String category; 
  final String userId;
  final int amount;
  final DateTime date; 
  final int color;
  final int codePointIcon;

  Expense({
    required this.expenseId,
    required this.category,
    required this.userId,
    required this.amount,
    required this.date,
    required this.color,
    required this.codePointIcon,
  });

  Map<String, dynamic> toMap() {
    return {
      'expenseId': expenseId,
      'categoryId': category,
      'userId': userId,
      'amount': amount,
      'date': date.toIso8601String(),
      'color': color,
      'codePointIcon': codePointIcon,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      expenseId: map['expenseId'],
      category: map['category'],
      userId: map['userId'],
      amount: map['amount'],
      date: (map['date'] as Timestamp).toDate(),
      color: map['color'],
      codePointIcon: map['codePointIcon'],
    );
  }

  IconData get icon => IconData(codePointIcon, fontFamily: 'MaterialIcons');

  Color get expenseColor => Color(color);
}


class ExpenseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Expense>> getExpensesByUserId(String userId) async {
    QuerySnapshot assetSnapshot = await _firestore
      .collection('expenses')
      .where('userId', isEqualTo: userId)
      .get();

    return assetSnapshot.docs
      .map((doc) => Expense.fromMap(doc.data() as Map<String, dynamic>))
      .toList().reversed.toList();
  }
}