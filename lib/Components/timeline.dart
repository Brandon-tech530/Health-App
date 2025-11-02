import 'package:flutter/material.dart';

class TimeGridPicker extends StatelessWidget {
  final Function(String) onTimeSelected;
  const TimeGridPicker({super.key, required this.onTimeSelected});

  @override
  Widget build(BuildContext context) {
    final times = List.generate(12, (i) => "${i + 8}:00"); // Example: 8:00 - 20:00

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: times.length,
      itemBuilder: (context, index) {
        final time = times[index];
        return OutlinedButton(
          onPressed: () => onTimeSelected(time),
          child: Text(time),
        );
      },
    );
  }
}
