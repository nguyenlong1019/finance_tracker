import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddAsset extends StatefulWidget {
  const AddAsset({super.key});

  @override
  State<AddAsset> createState() => _AddAssetState();
}

class _AddAssetState extends State<AddAsset> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController assetTypeController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ApplicationState>(context, listen: true);
    int balance = appState.balance ?? 0;
    String userId = appState.uid ?? '';
    

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Add Asset',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16,),
            TextFormField(
              controller: amountController,
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
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 16,),
            TextFormField(
              controller: assetTypeController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.wallet, 
                  size: 16,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                labelText: 'Asset Type',
              ),
            ),
            if (errorMessage != null) 
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 32,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: kToolbarHeight,
              child: TextButton(
                onPressed: () {
                  String assetType = assetTypeController.text;
                  int value = int.tryParse(amountController.text) ?? 0;
                  // print(amountController.text);

                  if (assetType.isNotEmpty && value > 0) {
                    _addAsset(assetType, value, userId, balance);
                    int newBalance = value + balance;
                    appState.setBalance(newBalance);
                  } 
                  if (assetType.isEmpty) {
                    setState(() {
                      errorMessage = "Please enter asset type ex: ATM, Cash";
                    });
                  }
                  if (value <= 0) {
                    setState(() {
                      errorMessage = "Amount must be positive";
                    });
                  }
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
    );
  }

  Future<void> _addAsset(String assetType, int value, String userId, int balance) async {
    try {
      String assetId = FirebaseFirestore.instance.collection('assets').doc().id;

      await FirebaseFirestore.instance.collection('assets').doc(assetId).set({
        'assetId': assetId,
        'name': assetType,
        'value': value,
        'userId': userId,
      });
      // print(userId);
      // int newBalance = balance + value;
      // await _firestore.collection('users').doc(userId).update({
      //   'balance': newBalance,
      // });

      QuerySnapshot userSnapshot = await _firestore
        .collection('users')
        .where('uid', isEqualTo: userId)  
        .limit(1) 
        .get();

      if (userSnapshot.docs.isNotEmpty) {
        var userDoc = userSnapshot.docs.first;
        int currentBalance = userDoc['balance'] ?? 0;

        int newBalance = currentBalance + value;
        await userDoc.reference.update({
          'balance': newBalance,
        });

        

      } else {
        setState(() {
          errorMessage = "User not found";
        });
      }

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }


}