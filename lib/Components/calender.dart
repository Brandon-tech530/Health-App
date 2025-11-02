import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

/// A reusable calendar date display widget.
/// Shows a calendar icon and the formatted date (Day, Date, Month, Year).
class CalendarDateContainer extends StatelessWidget {
  final DateTime date;
  final Color? backgroundColor;

  const CalendarDateContainer({
    super.key,
    required this.date,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Format: Monday, 23 Sep 2025
    final formattedDate = DateFormat('EEEE, d MMM yyyy').format(date);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 2),
          Text(
            formattedDate,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 10
                ),
          ),
          const SizedBox(width: 50),
          Icon(Icons.timer, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 2),
          Text(
            '7:30am - 11:59pm',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 10
                ),
          ),
        ],
      ),
    );
  }
}
