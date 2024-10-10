import 'package:finance_tracker/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: 'AIzaSyBsUXbN_MQHMamJnciAcpAnScAYnwASDdg', appId: '1:377746042023:android:3b5d88dcb3c8573715ff82', messagingSenderId: '377746042023', projectId: 'finance-tracker-715fa')
  );
  runApp(const MyApp());
}
