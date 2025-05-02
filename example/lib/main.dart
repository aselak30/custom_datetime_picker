import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:interval_datetime_picker/interval_datetime_picker.dart'; // Import localization

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Picker Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations
            .delegate, // Localization delegate for Material widgets
        GlobalWidgetsLocalizations
            .delegate, // Localization delegate for general widgets
      ],
      supportedLocales: [
        Locale('en', 'US'), // Adding support for English, US
        // You can add more locales as needed.
      ],
      home: Scaffold(
        appBar: AppBar(title: const Text('DateTime Picker Demo')),
        body: Center(
          child: ElevatedButton(
            child: const Text('Open Picker'),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (_) => CustomDateTimePicker(
                      initialDate: DateTime.now(),
                      interval: const Duration(minutes: 15),
                      pickerBackgroundColor: Colors.white,
                      titleTextStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      buttonTextStyle: const TextStyle(color: Colors.blue),
                      title: "Select Date & Time",
                      confirmText: "Confirm",
                      cancelText: "Cancel",
                      minDate: DateTime.now(),
                      maxDate: DateTime.now().add(const Duration(days: 7)),
                      onSelected: (dateTime) {
                        print("Selected date and time: $dateTime");
                      },
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
