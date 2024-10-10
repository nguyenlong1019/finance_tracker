import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';


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

  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  String? uid = null;
  String? username = null;
  String? email = null;
  String? phone = null;
  String? balance = null;

  Future<void> init() async {
      if (uid != null) {
        _loggedIn = true;
        ChangeNotifier();
      } else {
        _loggedIn = false;
        ChangeNotifier();
      }



  }


  Future<void> signUp(String username, String email, String phone, int balance, String pwd) async {
    String hashedPwd = _encryptionService.hashPassword(pwd);

    QuerySnapshot userSnapshot = await _firestore
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
    
    if (userSnapshot.docs.isNotEmpty) {
      throw Exception('Email already exists!');
    }

    await _firestore.collection('users').add({
      'username': username,
      'email': email,
      'phone': phone,
      'balance': balance,
      'pwd': hashedPwd,
    });
  }

  Future<void> signIn(String email, String pwd) async {
    String hashedPwd = _encryptionService.hashPassword(pwd);

    QuerySnapshot userSnapshot = await _firestore
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
    
    if (userSnapshot.docs.isNotEmpty) {
      var userDoc = userSnapshot.docs.first;
      if (userDoc['pwd'] == hashedPwd) {
        uid = userDoc['uid'];
        username = userDoc['username'];
        email = userDoc['email'];
        phone = userDoc['phone'];
        balance = userDoc['balance'];
        _loggedIn = true;
        ChangeNotifier();
      }
    }

    _loggedIn = false;
    ChangeNotifier();
  } 

  Future<void> signOut() async {
    uid = null;
    username = null;
    email = null;
    phone = null;
    balance = null;
    _loggedIn = false;
    ChangeNotifier();
  }
}

