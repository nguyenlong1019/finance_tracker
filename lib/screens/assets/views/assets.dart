import 'package:finance_tracker/app_state.dart';
import 'package:finance_tracker/models/asset.dart';
import 'package:finance_tracker/models/expense.dart';
import 'package:finance_tracker/screens/assets/views/add_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Assets',),
    Tab(text: 'Save'),
    Tab(text: 'Transactions'),
  ];

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  final AssetService _assetService = AssetService();
  final ExpenseService _expenseService = ExpenseService();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ApplicationState>(context, listen: true);
    int balance = appState.balance ?? 0;
    String userId = appState.uid ?? '';
    // print(appState.userId);

    return SafeArea(
      child: DefaultTabController(
        length: AssetsScreen.myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Account', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 139, 79, 229),
            bottom: TabBar(
              tabs: AssetsScreen.myTabs,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[400],
              indicatorColor: Colors.white,
              indicatorWeight: 6,
              dividerColor: Colors.white,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(  
                      builder: (BuildContext context) => const AddAsset(),
                    ),
                  );
                },
                icon: const CircleAvatar(
                  child: Icon(
                    CupertinoIcons.add, 
                    size: 20, 
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.amber,  
                ),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Text(
                            'Balance: $balance đ',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Expanded(
                        child: FutureBuilder<List<Asset>>(
                          future: _assetService.getAssetsByUserId(userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator(),);
                            } else if (snapshot.hasError) {
                              return const Center(child: Text('Error loading assets'),);
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(child: Text('No assets found'));
                            } else {
                              List<Asset> assets = snapshot.data!;
                              return ListView.builder(
                                itemCount: assets.length,
                                itemBuilder: (context, int i) {
                                  Asset asset = assets[i];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Màu và độ trong suốt của bóng
                                          spreadRadius: 1, // Độ lan của bóng
                                          blurRadius: 5, // Độ mờ của bóng
                                          offset: const Offset(0, 3), // Vị trí của bóng (x, y)
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      leading: const Icon(CupertinoIcons.money_dollar_circle),
                                      title: Text(asset.name),
                                      subtitle: Text('Amount: ${asset.value}'),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(

                ),
              ),
              Expanded(
                child: FutureBuilder<List<Expense>>(
                  future: _expenseService.getExpensesByUserId(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(),);
                    } else if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      return const Center(child: Text('Error loading assets'),);
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No expenses found'));
                    } else {
                      List<Expense> expenses = snapshot.data!;
                      return ListView.builder(
                        itemCount: expenses.length,
                        itemBuilder: (context, int i) {
                          Expense expense = expenses[i];
                          return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: expense.expenseColor, // Use the converted color
                            child: Icon(expense.icon, color: Colors.white), // Use the converted icon
                          ),
                          title: Text(expense.category),
                          subtitle: Text('${expense.amount} đ'),
                          trailing: Text(
                            DateFormat('dd/MM/yyyy').format(expense.date),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}