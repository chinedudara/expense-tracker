import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTxns;

  List<Map<String, Object>> get groupedTxVals {
    return List.generate(7, (index) {
      var totalSum = 0.0;
      DateTime weekDay = DateTime.now().subtract(Duration(days: index));
      for (var i = 0; i < _recentTxns.length; i++) {
        if (_recentTxns[i].date.day == weekDay.day &&
            _recentTxns[i].date.month == weekDay.month &&
            _recentTxns[i].date.year == weekDay.year) {
          totalSum += _recentTxns[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalAmt {
    return groupedTxVals.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  Chart(this._recentTxns);

  @override
  Widget build(BuildContext context) {
    // print(groupedTxVals);
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTxVals
                .map((gtx) => Flexible(fit: FlexFit.tight,
                                  child: ChartBar(
                      gtx['day'],
                      gtx['amount'],
                      totalAmt == 0.0
                          ? 0.0
                          : (gtx['amount'] as double) / totalAmt),
                ))
                .toList()),
      ),
    );
  }
}
