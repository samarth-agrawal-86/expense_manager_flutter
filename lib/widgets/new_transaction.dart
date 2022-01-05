import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class NewTransaction extends StatefulWidget {
  Function addTx;

  NewTransaction({Key? key, required this.addTx}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (value) {},
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedDate == null
                    ? Text('No Date Chosen!')
                    : Text(
                        'Picked Date ${intl.DateFormat.yMd().format(selectedDate!)}'),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          selectedDate = value;
                        });
                      }
                    });
                  },
                  child: Text(
                    'Choose Date',
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  amountController.text.isNotEmpty &&
                  selectedDate != null) {
                widget.addTx(
                    titleController.text, amountController.text, selectedDate);
              }
            },
            style: TextButton.styleFrom(
              shadowColor: Colors.purple,
            ),
            child: Text(
              'Add Transaction',
            ),
          )
        ],
      ),
    );
  }
}
