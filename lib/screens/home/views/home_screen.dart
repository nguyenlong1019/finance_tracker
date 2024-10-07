import 'dart:math'; // pi 

import 'package:finance_tracker/screens/add_expense/views/add_expense.dart';
import 'package:finance_tracker/screens/home/views/main_screen.dart';
import 'package:finance_tracker/screens/stats/stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var widgetList = [
    const HomeScreen(),
    const StatScreen(),
  ];

  int index = 0;

  Color selectedItem = Colors.blue;
  Color unselectedItem = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          onTap: (value) {
            // print(value);
            // if (value == 0) {
            //   // print("0000000000000000000");
            //   index = 0;
            // } else if (value == 1) {
            //   // print("1111111111111111111");
            //   index = 1;
            // } else {
              
            // }
            setState(() {
              index = value;
            });
          },
          // fixedColor: Colors.red,
          // selectedItemColor: Colors.red,
          // backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                color: index == 0 ? selectedItem : unselectedItem,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.graph_square_fill,
                color: index == 1 ? selectedItem : unselectedItem,
              ),
              label: 'Stats',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AddExpense(), 
            ),
          );
        },
        shape: const CircleBorder(), // circle 
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ],
              transform: const GradientRotation(pi / 4), 
            )
          ),
          child: const Icon(CupertinoIcons.add)),
      ),
      body: index == 0 ? MainScreen() : StatScreen(),
    );
  }
}