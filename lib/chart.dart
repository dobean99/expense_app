import 'package:expense_app/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      //Yesterday= today-1
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.00;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      // print(DateFormat.E().format(weekday).substring(0, 1));
      // print(totalSum);
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValue.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
   // print(groupedTransactionValue);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValue.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(data['day'], data['amount'],
                    totalSpending ==0.0? 0.0 :(data['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ),
    );
  }
}
