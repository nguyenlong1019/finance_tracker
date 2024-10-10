import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';


class EncryptionService {
  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final EncryptionService _encryptionService = EncryptionService();

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

  Future<bool> signIn(String email, String pwd) async {
    String hashedPwd = _encryptionService.hashPassword(pwd);

    QuerySnapshot userSnapshot = await _firestore
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
    
    if (userSnapshot.docs.isNotEmpty) {
      var userDoc = userSnapshot.docs.first;
      if (userDoc['pwd'] == hashedPwd) {
        return true;
      }
    }

    return false;
  } 

  Future<void> signOut() async {

  }

}