import 'package:finance_tracker/app_state.dart';
import 'package:finance_tracker/screens/home/views/home_screen.dart';
import 'package:finance_tracker/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      child: Consumer<ApplicationState>(
        builder: (context, appState, _) {
          return MaterialApp(
            title: 'Finance Tracker',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.light(
                // background: Colors.grey.shade100, // background and onBackground -> surface and onSurface
                // onBackground: Colors.black,
                surface: Colors.grey.shade100,
                onSurface: Colors.black,
                primary: const Color(0xFF00B2E7),
                secondary: const Color(0xFFE064F7),
                tertiary: const Color(0xFFFF8D6C),
                outline: Colors.grey,
              ),
            ),
            home: appState.loggedIn ? const HomeScreen() : const LoginScreen(),
          );
        },
      ),
    );
  }
}

// #00B2E7 
// #E064F7 
// #FF8D6C