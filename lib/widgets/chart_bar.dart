import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double amountPct;

  ChartBar(
      {required this.label, required this.amount, required this.amountPct});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text('\$${amount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border.all(
                      color: Colors.grey, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: amountPct,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
