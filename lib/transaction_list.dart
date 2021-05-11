import 'package:flutter/material.dart';
import 'transaction.dart';
import 'transaction_Item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
      //Image
          ? LayoutBuilder(builder: (ctx, constrains) {
        return Column(
          children: <Widget>[
            Text('No transaction added yet!'),
            Container(
              height: constrains.maxHeight * 0.7,
              child: Image.asset(
                'assets/images/waiting.png',
                //fit: BoxFit.cover,
              ),
            ),
          ],
        );
      })

      //List transaction
          : ListView.builder(
        itemBuilder: (ctx, index) {
          return TransactionItem(transactions[index], deleteTx);
        },
        itemCount: transactions.length,
      ),
    );
  }
}
