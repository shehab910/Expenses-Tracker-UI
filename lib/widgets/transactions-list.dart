import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> txList;
  final Function deleteTx;

  TransactionList(this.txList, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: txList.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 15),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (cxt, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 3,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${txList[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              txList[index].title.replaceRange(
                                    0,
                                    1,
                                    txList[index]
                                        .title
                                        .substring(0, 1)
                                        .toUpperCase(),
                                  ),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 4),
                            Text(
                              DateFormat.yMMMEd()
                                  .format(txList[index].dateTime),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete_forever_rounded,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () => deleteTx(txList[index].id),
                          // alignment: Alignment.centerRight,
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: txList.length,
            ),
    );
  }
}
