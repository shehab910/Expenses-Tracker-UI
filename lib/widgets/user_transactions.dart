import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transactions-list.dart';
import '../models/transaction.dart';

class UserTrenasactions extends StatefulWidget {
  @override
  _UserTrenasactionsState createState() => _UserTrenasactionsState();
}

class _UserTrenasactionsState extends State<UserTrenasactions> {
  final _userTransactions = [
    Transaction(title: 'phone', amount: 2000, dateTime: DateTime.now()),
    Transaction(title: 'headphones', amount: 500, dateTime: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      dateTime: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
