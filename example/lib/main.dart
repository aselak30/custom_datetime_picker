import 'package:flutter/material.dart';
import 'package:interval_datetime_picker/interval_datetime_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Package Test')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open Picker'),
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (_) => CustomDateTimePicker(
                    pickerBackgroundColor: Colors.white,
                    initialDate: DateTime.now(),
                    interval: const Duration(minutes: 15),
                    onSelected: (dt) {
                      debugPrint('Selected: $dt');
                    },
                  ),
            );
          },
        ),
      ),
    );
  }
}
