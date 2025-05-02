import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTimePicker extends StatelessWidget {
  final Function(DateTime) onSelected;
  final VoidCallback? onCancel;
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
    this.onCancel,
    required this.initialDate,
    this.interval = const Duration(minutes: 15),
    this.pickerBackgroundColor = Colors.white,
    this.titleTextStyle =
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    this.buttonTextStyle = const TextStyle(fontSize: 16, color: Colors.white),
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

    while (start.isBefore(end)) {
      if ((minDate == null || start.isAfter(minDate!)) &&
          (maxDate == null || start.isBefore(maxDate!))) {
        timeSlots.add(start);
      }
      start = start.add(interval);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      backgroundColor: pickerBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 400,
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleTextStyle),
              const SizedBox(height: 15),
              Flexible(
                child: ListView.separated(
                  itemCount: timeSlots.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final time = timeSlots[index];
                    return _HoverableTimeCard(
                      time: time,
                      onTap: () => onSelected(time),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    onPressed: onCancel ?? () => Navigator.of(context).pop(),
                    child: Text(cancelText,
                        style: buttonTextStyle.copyWith(color: Colors.red)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(confirmText, style: buttonTextStyle),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HoverableTimeCard extends StatefulWidget {
  final DateTime time;
  final VoidCallback onTap;

  const _HoverableTimeCard({Key? key, required this.time, required this.onTap})
      : super(key: key);

  @override
  State<_HoverableTimeCard> createState() => _HoverableTimeCardState();
}

class _HoverableTimeCardState extends State<_HoverableTimeCard> {
  bool isHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: isPressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: isHovered ? Colors.blue.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isHovered || isPressed
                  ? [
                      BoxShadow(
                        color: Colors.black
                            .withValues(red: 0, green: 0, blue: 0, alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              splashColor:
                  Colors.blue.withValues(red: 0, green: 0, blue: 0.1, alpha: 0),
              onTap: widget.onTap,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('hh:mm a').format(widget.time),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Icon(Icons.access_time, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
