import 'package:flutter/material.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Assets',),
    Tab(text: 'Save'),
    Tab(text: 'Transactions'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Account', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),),
            centerTitle: true,
            backgroundColor: Color(0xFF08C2FF),
            bottom: const TabBar(
              tabs: myTabs,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [
              Expanded(child: Text('1')),
              Expanded(child: Text('2')),
              Expanded(child: Text('3')),
            ],
          ),
        ),
      ),
    );
  }
}