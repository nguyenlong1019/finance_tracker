import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/asset.dart';
import 'package:finance_tracker/models/expense.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final String phone;
  final int balance;
  final String pwd;

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.phone,
    required this.balance,
    required this.pwd,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'phone': phone,
      'balance': balance,
      'pwd': pwd,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      balance: map['balance'],
      pwd: map['pwd'],
    );
  }
}

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> getUserById(String userId) async {
    DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();
    if (userSnapshot.exists) {
      return User.fromMap(userSnapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUserBalance(String userId, int newBalance) async {
    await _firestore.collection('users').doc(userId).update({
      'balance': newBalance,
    });
  }

  

  
}