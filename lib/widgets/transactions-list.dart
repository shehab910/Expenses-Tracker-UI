import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> txList;

  TransactionList(this.txList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: txList.map((tx) {
        return Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple[800],
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  '\$${tx.amount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.purple[800],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.title.replaceRange(
                      0,
                      1,
                      tx.title.substring(0, 1).toUpperCase(),
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.5,
                      color: Colors.black,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    DateFormat.yMMMEd().format(tx.dateTime),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
