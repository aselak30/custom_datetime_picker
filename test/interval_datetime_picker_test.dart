import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interval_datetime_picker/interval_datetime_picker.dart';

void main() {
  testWidgets('CustomDateTimePicker builds and shows time list',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CustomDateTimePicker(
                  initialDate: DateTime.now(),
                  interval: const Duration(minutes: 15),
                  onSelected: (dateTime) {},
                ),
              );
            },
            child: const Text('Open Picker'),
          ),
        ),
      ),
    );

    // Tap the button to open the picker
    await tester.tap(find.text('Open Picker'));
    await tester.pumpAndSettle();

    // Expect to find list tiles (time slots)
    expect(find.byType(ListTile), findsWidgets);
  });
}
