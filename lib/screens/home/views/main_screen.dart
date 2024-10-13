import 'dart:math';

import 'package:finance_tracker/app_state.dart';
import 'package:finance_tracker/data/data.dart';
import 'package:finance_tracker/models/asset.dart';
import 'package:finance_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ExpenseService _expenseService = ExpenseService();

  @override 
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ApplicationState>(context, listen: false);
    int balance = appState.balance ?? 0;
    String userId = appState.uid ?? '';
    int income = appState.totalAssets;
    int expenses = appState.totalExpenses;
    // print(income);
    // print(expenses);

    // Tính tỷ lệ phần trăm chi tiêu so với thu nhập
    double expensePercentage = income > 0 ? (expenses / income) * 100 : 0;
    String alertMessage = '';
    Color backgroundColor = Colors.green; // Mặc định màu xanh 

    // Xác định cảnh báo và màu nền dựa trên tỷ lệ phần trăm
    if (expensePercentage < 50) {
      alertMessage = 'Good job! Your expenses are well controlled.';
      backgroundColor = Colors.green;
    } else if (expensePercentage >= 50 && expensePercentage <= 80) {
      alertMessage = 'Warning! Your expenses are getting high.';
      backgroundColor = Colors.orange;
    } else if (expensePercentage > 80) {
      alertMessage = 'Alert! Your expenses are too high.';
      backgroundColor = Colors.red;
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow[700],
                          ),
                        ),
                        Icon(
                          CupertinoIcons.person_fill,
                          color: Colors.yellow[800],
                        ),
                      ],
                    ),
                    const SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        Text(
                          appState.username ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.settings),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              // width: double.infinity, // width = screen width
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.tertiary,
                  ],
                  transform: const GradientRotation(pi / 4), 
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.grey.shade300,
                    offset: const Offset(5, 5),
                  ),
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Balance',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Text(
                    '$balance đ',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.arrow_down,
                                  size: 12,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Income',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '$income đ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.arrow_up,
                                  size: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expenses',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '$expenses đ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40,),
            // Alert here
            // Alert container with dynamic background color and message
            Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                alertMessage,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: transactionsData.length,
            //     itemBuilder: (context, int i) {
            //       return Padding(
            //         padding: const EdgeInsets.only(bottom: 8.0),
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: Colors.white, // background color
            //             borderRadius: BorderRadius.circular(12),
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.all(16.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Row(
            //                   children: [
            //                     Stack(
            //                       alignment: Alignment.center,
            //                       children: [
            //                         Container(
            //                           width: 50,
            //                           height: 50,
            //                           decoration: BoxDecoration(
            //                             color: transactionsData[i]['color'],
            //                             shape: BoxShape.circle,
            //                           ),
            //                         ),
            //                         transactionsData[i]['icon'],
            //                         // const Icon(
            //                         //   Icons.food_bank,
            //                         //   color: Colors.white,
            //                         // ),
            //                       ],
            //                     ),
            //                     const SizedBox(width: 12,),
            //                     Text(
            //                       transactionsData[i]['name'],
            //                       style: TextStyle(
            //                         fontSize: 14,
            //                         color: Theme.of(context).colorScheme.onSurface,
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.end,
            //                   children: [
            //                     Text(
            //                       transactionsData[i]['totalAmount'],
            //                       style: TextStyle(
            //                         fontSize: 14,
            //                         color: Theme.of(context).colorScheme.onSurface,
            //                         fontWeight: FontWeight.w400,
            //                       ),
            //                     ),
            //                     Text(
            //                       transactionsData[i]['date'],
            //                       style: TextStyle(
            //                         fontSize: 14,
            //                         color: Theme.of(context).colorScheme.outline,
            //                         fontWeight: FontWeight.w400,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
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
    );
  }
}