import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/app_state.dart';
import 'package:finance_tracker/screens/home/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  String? errorMessage;
  IconData? icon;
  Color? color;

  List<String> myCategoriesIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel',
  ];


  @override 
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ApplicationState>(context, listen: true);
    String userId = appState.uid ?? '';
    int balance = appState.balance ?? 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ), 
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Add Expenses',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16,), 
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: expenseController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.dollarSign, 
                      size: 16,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32,),
              TextFormField(
                controller: categoryController,
                textAlignVertical: TextAlignVertical.center,
                // readOnly: true,
                onTap: () {

                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.list, 
                    size: 16,
                    color: Colors.grey,
                  ),
                  // suffixIcon: IconButton(
                  //   onPressed: () {
                  //     showDialog(
                  //       context: context, 
                  //       builder: (context) {
                  //         bool isExpended = false;
                  //         String iconSelected = '';
                  //         Color categoryColor = Colors.white;

                  //         return StatefulBuilder(
                  //           builder: (context, setState) {
                  //             return AlertDialog(
                  //               title: const Text(
                  //                 'Create a Category',
                  //               ),
                  //               backgroundColor: Colors.pink[50],
                  //               content: SizedBox(
                  //                 width: MediaQuery.of(context).size.width,
                  //                 child: Column(
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   children: [
                                      
                  //                     TextFormField(
                  //                       // controller: dateController,
                  //                       textAlignVertical: TextAlignVertical.center,
                  //                       // readOnly: true,
                  //                       decoration: InputDecoration(
                  //                         isDense: true,
                  //                         filled: true,
                  //                         fillColor: Colors.white,
                  //                         hintText: 'Name',
                  //                         border: OutlineInputBorder(
                  //                           borderRadius: BorderRadius.circular(12),
                  //                           borderSide: BorderSide.none,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const SizedBox(height: 16,),
                  //                     TextFormField(
                  //                       // controller: dateController,
                  //                       onTap: () {
                  //                         setState(() {
                  //                           isExpended = !isExpended;
                  //                         });
                  //                       },
                  //                       textAlignVertical: TextAlignVertical.center,
                  //                       readOnly: true,
                  //                       decoration: InputDecoration(
                  //                         isDense: true,
                  //                         filled: true,
                  //                         fillColor: Colors.white,
                  //                         suffixIcon: const Icon(CupertinoIcons.chevron_down, size: 12,),
                  //                         hintText: 'Icon',
                  //                         border: OutlineInputBorder(
                  //                           borderRadius: isExpended ? const BorderRadius.vertical(
                  //                             top: Radius.circular(12),
                  //                           ) : BorderRadius.circular(12),
                  //                           borderSide: BorderSide.none,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     isExpended ? Container(
                  //                       width: MediaQuery.of(context).size.width,
                  //                       height: 200,
                  //                       decoration: const BoxDecoration(
                  //                         color: Colors.white,
                  //                         borderRadius: BorderRadius.vertical(
                  //                           bottom: Radius.circular(12),
                  //                         ),
                  //                       ), 
                  //                       child: Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: GridView.builder(
                  //                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //                             crossAxisCount: 3,
                  //                             mainAxisSpacing: 5,
                  //                             crossAxisSpacing: 5,
                  //                           ),
                  //                           itemCount: myCategoriesIcons.length,
                  //                           itemBuilder: (context, int i) {
                  //                             return GestureDetector(
                  //                               onTap: () {
                  //                                 setState(() {
                  //                                   iconSelected = myCategoriesIcons[i];
                  //                                 });
                  //                               },
                  //                               child: Container(
                  //                                 width: 50,
                  //                                 height: 50,
                  //                                 decoration: BoxDecoration(
                  //                                   border: Border.all(
                  //                                     width: 2,
                  //                                     color: iconSelected == myCategoriesIcons[i] ? Colors.green : Colors.grey,
                  //                                   ),
                  //                                   borderRadius: BorderRadius.circular(12),
                  //                                   image: DecorationImage(
                  //                                     image: AssetImage(
                  //                                       'assets/${myCategoriesIcons[i]}.png',
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             );
                  //                           },
                  //                         ),
                  //                       ),
                  //                     ) : Container(),
                  //                     const SizedBox(height: 16,),
                  //                     TextFormField(
                  //                       // controller: dateController,
                  //                       onTap: () {
                  //                         showDialog(
                  //                           context: context, 
                  //                           builder: (context) {
                  //                             return AlertDialog(
                  //                               content: Column(
                  //                                 mainAxisSize: MainAxisSize.min,
                  //                                 children: [
                  //                                   ColorPicker(
                  //                                     pickerColor: categoryColor,
                  //                                     onColorChanged: (value) {
                  //                                       setState(() {
                  //                                         categoryColor = value;
                  //                                       });
                  //                                     },
                  //                                   ),
                  //                                   SizedBox(
                  //                                     width: double.infinity,
                  //                                     height: 50,
                  //                                     child: TextButton(
                  //                                       onPressed: () {
                  //                                         // print(categoryColor);
                  //                                         Navigator.pop(context);
                  //                                       }, 
                  //                                       style: TextButton.styleFrom(
                  //                                         backgroundColor: Colors.black,
                  //                                         shape: RoundedRectangleBorder(
                  //                                           borderRadius: BorderRadius.circular(12)
                  //                                         )
                  //                                       ),
                  //                                       child: const Text(
                  //                                         'Save',
                  //                                         style: TextStyle(
                  //                                           fontSize: 22,
                  //                                           color: Colors.white,
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             );
                  //                           },
                  //                         );
                  //                       },
                  //                       textAlignVertical: TextAlignVertical.center,
                  //                       readOnly: true,
                  //                       decoration: InputDecoration(
                  //                         isDense: true,
                  //                         filled: true,
                  //                         fillColor: categoryColor,
                  //                         hintText: 'Color',
                  //                         border: OutlineInputBorder(
                  //                           borderRadius: BorderRadius.circular(12),
                  //                           borderSide: BorderSide.none,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const SizedBox(height: 16,),
                  //                     if (errorMessage != null)
                  //                       Padding(
                  //                         padding: const EdgeInsets.only(bottom: 16),
                  //                         child: Text(
                  //                           errorMessage!,
                  //                           style: const TextStyle(color: Colors.red),
                  //                         ),
                  //                       ),
                  //                     SizedBox(
                  //                       width: double.infinity,
                  //                       height: kToolbarHeight,
                  //                       child: TextButton(
                  //                         onPressed: () async {
                  //                           _saveExpense(userId);
                  //                         }, 
                  //                         style: TextButton.styleFrom(
                  //                           backgroundColor: Colors.black,
                  //                           shape: RoundedRectangleBorder(
                  //                             borderRadius: BorderRadius.circular(12)
                  //                           )
                  //                         ),
                  //                         child: const Text(
                  //                           'Save',
                  //                           style: TextStyle(
                  //                             fontSize: 22,
                  //                             color: Colors.white,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         );
                  //       },
                  //     );
                  //   },
                  //   icon: const Icon(
                  //     FontAwesomeIcons.plus, 
                  //     size: 16,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                  hintText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: dateController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context, 
                    initialDate: selectDate,
                    firstDate: DateTime.now(), 
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );

                  if (newDate != null) {
                    setState(() {
                      dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                      selectDate = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.clock, 
                    size: 16,
                    color: Colors.grey,
                  ),
                  hintText: 'Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32,),
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: TextButton(
                  onPressed: () async {
                    _saveExpense(userId);
                    int amount = int.tryParse(expenseController.text) ?? 0;
                    int newBalance = balance - amount;
                    appState.setBalance(newBalance);
                  }, 
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveExpense(userId) async {
    int? amount = int.tryParse(expenseController.text);
    String category = categoryController.text;

    if (amount == null || amount <= 0) {
      setState(() {
        errorMessage = 'Please enter a valid amount';
      });
      return;
    }

    if (category.isEmpty) {
      setState(() {
        errorMessage = 'Please select a category';
      });
      return;
    }

    if (category == 'Food') {
      icon = Icons.fastfood;
      color = Colors.orange;
    } else if (category == 'Shopping') {
      icon = Icons.shopping_bag;
      color = Colors.purple;
    } else if (category == 'Health') {
      icon = Icons.health_and_safety;
      color = Colors.green;
    } else if (category == 'Travel') {
      icon = Icons.flight;
      color = Colors.blue;
    } else if (category == 'Entertainment') {
      icon = Icons.movie;
      color = Colors.red;
    } else if (category == 'Home') {
      icon = Icons.home;
      color = Colors.brown;
    } else if (category == 'Pet') {
      icon = Icons.pets;
      color = Colors.amber;
    } else if (category == 'Tech') {
      icon = Icons.computer;
      color = Colors.cyan;
    } else {
      icon = Icons.category;
      color = Colors.grey;
    }

    try {
      String expenseId = FirebaseFirestore.instance.collection('expenses').doc().id;

      await FirebaseFirestore.instance.collection('expenses').add({
        'expenseId': expenseId,
        'userId': userId,
        'amount': amount,
        'category': category,
        'date': selectDate,
        'codePointIcon': icon!.codePoint,
        'color': color!.value, // Save color as an integer
      });

      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: userId)  
        .limit(1) 
        .get();

      if (userSnapshot.docs.isNotEmpty) {
        var userDoc = userSnapshot.docs.first;
        int currentBalance = userDoc['balance'] ?? 0;

        int newBalance = currentBalance - amount;
        await userDoc.reference.update({
          'balance': newBalance,
        });

        

      } else {
        setState(() {
          errorMessage = "User not found";
        });
      }
      
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to save expense. Please try again.';
      });
    }
  }

}