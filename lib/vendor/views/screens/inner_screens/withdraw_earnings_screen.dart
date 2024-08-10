import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

class WithdrawEarningsScreen extends StatefulWidget {
  @override
  State<WithdrawEarningsScreen> createState() => _WithdrawEarningsScreenState();
}

class _WithdrawEarningsScreenState extends State<WithdrawEarningsScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String bankName;

  late String accountName;

  late String accountNumber;

  late String amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'withdraw earnings',
        ),
        iconTheme: IconThemeData(
          color: Colors.pink,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  onChanged: (value) {
                    bankName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please fill in';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'bank name',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                    hintText: 'enter bank name',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    accountName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please fill in';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Account name',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                    hintText: 'enter account name',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    accountNumber = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please fill in';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'account number',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                    hintText: 'enter account number',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    amount = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please fill in';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'amount',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                    hintText: 'enter amount',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () async {
                    DocumentSnapshot userDoc = await _firestore
                        .collection('vendors')
                        .doc(_auth.currentUser!.uid)
                        .get();
                    if (_formkey.currentState!.validate()) {
                      final withDrawId = Uuid().v4();
                      EasyLoading.show();
                      await _firestore
                          .collection('withdrawal')
                          .doc(withDrawId)
                          .set({
                        'bussinessName': (userDoc.data()
                            as Map<String, dynamic>)['bussinessName'],
                        'bankName': bankName,
                        'accountName': accountName,
                        'accountNumber': accountNumber,
                        'amount': amount,
                      }).whenComplete(() {
                        EasyLoading.dismiss();
                      });
                    } else {
                      print('bad');
                    }
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'get cash',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
