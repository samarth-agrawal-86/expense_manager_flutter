import 'package:expense_manager/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart' as intl;

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (Transaction tx in recentTransactions) {
        if (intl.DateFormat('yyyy-MM-dd').format(weekDay) ==
            intl.DateFormat('yyyy-MM-dd').format(tx.date)) {
          totalSum = totalSum + tx.amount;
        }
      }
      return {
        'day': intl.DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get getTotalAmount {
    double totalAmount = 0.0;
    for (var item in groupedTransactions) {
      totalAmount = totalAmount + double.parse(item['amount'].toString());
    }
    return totalAmount;
  }

  Chart({required this.recentTransactions});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ChartBar(
                  label: data['day'].toString(),
                  amount: double.parse(data['amount'].toString()),
                  amountPct: getTotalAmount == 0.0
                      ? 0.0
                      : double.parse(data['amount'].toString()) /
                          getTotalAmount),
            );
          }).toList()),
    );
  }
}
