import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';


class EncryptionService {
  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}


class ApplicationState extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final EncryptionService _encryptionService = EncryptionService();
  final Uuid _uuid = Uuid();

  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  String? userId;
  String? uid;
  String? username;
  String? email;
  String? phone;
  int? balance;

  int totalAssets = 0;
  int totalExpenses = 0;

  void setBalance(int value) {
    balance = value;
    notifyListeners();
    _recalculateTotals();
  }

  Future<void> init() async {
      if (uid != null) {
        _loggedIn = true;
        notifyListeners();
      } else {
        _loggedIn = false;
        notifyListeners();
      }



  }

  Future<void> _recalculateTotals() async {
    if (uid == null) return;

    try {
      // Lấy danh sách tài sản và chi tiêu từ Firestore theo userId
      QuerySnapshot assetSnapshot = await _firestore
          .collection('assets')
          .where('userId', isEqualTo: uid)
          .get();

      QuerySnapshot expenseSnapshot = await _firestore
          .collection('expenses')
          .where('userId', isEqualTo: uid)
          .get();

      // Tính tổng tài sản và chuyển kết quả sang int
      totalAssets = assetSnapshot.docs.fold(0, (int sum, doc) {
        var data = doc.data() as Map<String, dynamic>;
        return sum + (data['value'] as num).toInt();  // Chuyển đổi rõ ràng thành int
      });

      // Tính tổng chi tiêu và chuyển kết quả sang int
      totalExpenses = expenseSnapshot.docs.fold(0, (int sum, doc) {
        var data = doc.data() as Map<String, dynamic>;
        return sum + (data['amount'] as num).toInt();  // Chuyển đổi rõ ràng thành int
      });

      print(totalAssets);
      print(totalExpenses);

      notifyListeners(); // Cập nhật UI khi tổng tài sản và chi tiêu thay đổi
    } catch (e) {
      print('Error calculating totals: $e');
    }
  }



  Future<String> signUp(String username, String email, String phone, int balance, String pwd) async {
    String hashedPwd = _encryptionService.hashPassword(pwd);

    QuerySnapshot userSnapshot = await _firestore
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
    
    if (userSnapshot.docs.isNotEmpty) {
      return 'Email already exists!';
    }

    String uid = _uuid.v4();

    await _firestore.collection('users').add({
      'uid': uid,
      'username': username,
      'email': email,
      'phone': phone,
      'balance': balance,
      'pwd': hashedPwd,
    });

    return 'Success';
  }

  Future<String> signIn(String email, String pwd) async {
    String hashedPwd = _encryptionService.hashPassword(pwd);

    QuerySnapshot userSnapshot = await _firestore
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
    
    if (userSnapshot.docs.isNotEmpty) {
      var userDoc = userSnapshot.docs.first;

      if (userDoc['pwd'] != hashedPwd) {
        return 'Incorect password!';
      }

      if (userDoc['pwd'] == hashedPwd) {
        // print(userDoc['email']);
        // print(userDoc['email'].runtimeType);
        userId = userDoc.id;
        uid = userDoc['uid'];
        username = userDoc['username'];
        this.email = userDoc['email'];
        // print(this.email);
        phone = userDoc['phone'];
        balance = userDoc['balance'];
        _loggedIn = true;
        notifyListeners();
        await _recalculateTotals();
        return 'Success';
      }
    }

    _loggedIn = false;
    notifyListeners();
    return 'Email does not exist!';
  } 

  Future<void> signOut() async {
    uid = null;
    username = null;
    email = null;
    phone = null;
    balance = null;
    _loggedIn = false;
    notifyListeners();
  }
}

