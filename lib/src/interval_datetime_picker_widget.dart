import 'package:flutter/material.dart';

class CustomDateTimePicker extends StatelessWidget {
  final Function(DateTime) onSelected;
  final DateTime initialDate;
  final Duration interval;
  final Color pickerBackgroundColor;
  final TextStyle titleTextStyle;
  final TextStyle buttonTextStyle;
  final String title;
  final String confirmText;
  final String cancelText;
  final DateTime? minDate;
  final DateTime? maxDate;

  const CustomDateTimePicker({
    Key? key,
    required this.onSelected,
    required this.initialDate,
    this.interval = const Duration(minutes: 15),
    this.pickerBackgroundColor = Colors.white,
    this.titleTextStyle = const TextStyle(fontSize: 18, color: Colors.black),
    this.buttonTextStyle = const TextStyle(color: Colors.blue),
    this.title = 'Select Date & Time',
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.minDate,
    this.maxDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DateTime> timeSlots = [];
    DateTime start = initialDate;
    DateTime end = initialDate.add(const Duration(hours: 24));

    // Adjusting time slots based on interval
    while (start.isBefore(end)) {
      if ((minDate == null || start.isAfter(minDate!)) &&
          (maxDate == null || start.isBefore(maxDate!))) {
        timeSlots.add(start);
      }
      start = start.add(interval);
    }

    return AlertDialog(
      title: Text(title, style: titleTextStyle),
      content: Container(
        color: pickerBackgroundColor,
        height: 300,
        child: Column(
          children: [
            // Displaying time slots
            Expanded(
              child: ListView.builder(
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  final time = timeSlots[index];
                  return ListTile(
                    title: Text(
                      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                    ),
                    onTap: () => onSelected(time),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Buttons to confirm or cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Confirm action
                  },
                  child: Text(confirmText, style: buttonTextStyle),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cancel action
                  },
                  child: Text(cancelText, style: buttonTextStyle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
