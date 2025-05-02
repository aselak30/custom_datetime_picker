import 'package:flutter/material.dart';
import 'package:custom_datetime_picker/custom_datetime_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom DateTime Picker Example')),
        body: Center(
          child: ElevatedButton(
            child: const Text('Pick Time'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDateTimePicker(
                    initialDate: DateTime.now(),
                    onSelected: (value) {
                      print('Selected: $value');
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
