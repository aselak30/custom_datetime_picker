import 'package:flutter/material.dart';

class CustomDateTimePicker extends StatelessWidget {
  final Function(DateTime) onSelected;
  final DateTime initialDate;
  final Duration interval;

  const CustomDateTimePicker({
    Key? key,
    required this.onSelected,
    required this.initialDate,
    this.interval = const Duration(minutes: 15),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DateTime> timeSlots = [];
    DateTime start = initialDate;
    DateTime end = initialDate.add(const Duration(hours: 24));

    while (start.isBefore(end)) {
      timeSlots.add(start);
      start = start.add(interval);
    }

    return AlertDialog(
      title: const Text('Select Time'),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: ListView.builder(
          itemCount: timeSlots.length,
          itemBuilder: (context, index) {
            final time = timeSlots[index];
            return ListTile(
              title: Text(
                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'),
              onTap: () => onSelected(time),
            );
          },
        ),
      ),
    );
  }
}
