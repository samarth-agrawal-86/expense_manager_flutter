import 'package:expense_manager/model/transaction.dart';
import 'package:expense_manager/widgets/chart.dart';
import 'package:expense_manager/widgets/new_transaction.dart';
import 'package:expense_manager/widgets/transaction_list.dart';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 59.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Grocery',
      amount: 19.99,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't3',
      title: 'Hotel',
      amount: 299.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't4',
      title: 'Shopping',
      amount: 63,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't5',
      title: 'Medical',
      amount: 320,
      date: DateTime.now().subtract(Duration(days: 10)),
    ),
  ];

  List<Transaction> get getRecentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, String txAmount, DateTime txDate) {
    Transaction newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: double.parse(txAmount),
      date: txDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void showNewTransactionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(addTx: _addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: [
          IconButton(
            onPressed: () {
              showNewTransactionSheet(context);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTransactions: getRecentTransactions),
            TransactionList(
              transactions: _userTransactions,
              deleteTx: _deleteTransaction,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNewTransactionSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
