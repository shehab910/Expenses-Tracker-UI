import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 3,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              '\$${transaction.amount.toStringAsFixed(2)}',
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
                  transaction.title.replaceRange(
                    0,
                    1,
                    transaction.title.substring(0, 1).toUpperCase(),
                  ),
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat.yMMMEd().format(transaction.dateTime),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (MediaQuery.of(context).size.width > 460)
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: FittedBox(
                child: FlatButton.icon(
                  label: const Text('Delete'),
                  textColor: Theme.of(context).errorColor,
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                  ),
                  onPressed: () => deleteTx(transaction.id),
                  // alignment: Alignment.centerRight,
                ),
              ),
            ),
          if (!(MediaQuery.of(context).size.width > 460))
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: IconButton(
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => deleteTx(transaction.id),
                // alignment: Alignment.centerRight,
              ),
            ),
        ],
      ),
    );
  }
}
