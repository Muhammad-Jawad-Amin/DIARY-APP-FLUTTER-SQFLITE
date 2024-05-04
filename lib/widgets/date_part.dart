import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePart extends StatelessWidget {
  final DateTime date;

  const DatePart({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.red,
      ),
      child: Column(
        children: [
          Text(
            DateFormat(DateFormat.ABBR_MONTH).format(date),
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            DateFormat(DateFormat.DAY).format(date),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            DateFormat(DateFormat.YEAR).format(date),
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
